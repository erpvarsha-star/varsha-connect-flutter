const admin = require("firebase-admin");
const fs = require("fs");
const path = require("path");

const dryRun = !process.argv.includes("--write");
const seedDir = path.resolve(__dirname, "..", "seed_output");
const templatesDir = path.resolve(__dirname, "..", "seed_templates");

admin.initializeApp({
  projectId: "yoyo-491123",
});

const db = admin.firestore();

async function main() {
  const jobs = [
    ["users", readJson(path.join(seedDir, "users_from_active_109.json")).users],
    ["departments", readJson(path.join(seedDir, "departments_from_active_109.json")).departments],
    ["role_kras", readJson(path.join(seedDir, "role_kras_from_sql.json")).role_kras],
    ["role_kpis", readJson(path.join(seedDir, "role_kpis_from_sql.json")).role_kpis],
    ["shifts", readJson(path.join(templatesDir, "shifts.json")).shifts],
    ["plant_config", readJson(path.join(templatesDir, "plant_config.json")).plant_config],
    ["form_templates", readJson(path.join(templatesDir, "form_templates_priority1.json")).form_templates],
  ];

  for (const [collection, records] of jobs) {
    const count = Object.keys(records).length;
    console.log(`${dryRun ? "DRY RUN" : "WRITE"} ${collection}: ${count} records`);
    if (!dryRun) await writeCollection(collection, records);
  }
}

async function writeCollection(collection, records) {
  let batch = db.batch();
  let pending = 0;

  for (const [id, data] of Object.entries(records)) {
    batch.set(db.collection(collection).doc(id), data, { merge: true });
    pending += 1;
    if (pending === 400) {
      await batch.commit();
      batch = db.batch();
      pending = 0;
    }
  }

  if (pending > 0) await batch.commit();
}

function readJson(filePath) {
  return JSON.parse(fs.readFileSync(filePath, "utf8"));
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
