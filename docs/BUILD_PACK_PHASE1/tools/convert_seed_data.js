const fs = require("fs");
const path = require("path");

const root = path.resolve(__dirname, "..", "..");
const outDir = path.resolve(__dirname, "..", "seed_output");

fs.mkdirSync(outDir, { recursive: true });

const employeesSql = fs.readFileSync(path.join(root, "employees_active_109_seed.sql"), "utf8");
const kraSql = fs.readFileSync(path.join(root, "varsha_kra_operations (2).sql"), "utf8");

function splitSqlTuple(line) {
  const start = line.indexOf("(");
  const end = line.lastIndexOf(")");
  if (start < 0 || end < 0) return [];
  const body = line.slice(start + 1, end);
  const values = [];
  let current = "";
  let inQuote = false;

  for (let i = 0; i < body.length; i += 1) {
    const char = body[i];
    const next = body[i + 1];
    if (char === "'" && next === "'") {
      current += "'";
      i += 1;
      continue;
    }
    if (char === "'") {
      inQuote = !inQuote;
      continue;
    }
    if (char === "," && !inQuote) {
      values.push(cleanValue(current));
      current = "";
      continue;
    }
    current += char;
  }
  values.push(cleanValue(current));
  return values;
}

function cleanValue(value) {
  const trimmed = value.trim();
  if (trimmed === "true") return true;
  if (trimmed === "false") return false;
  if (trimmed === "null" || trimmed === "NULL") return null;
  const numberValue = Number(trimmed);
  if (trimmed !== "" && Number.isFinite(numberValue)) return numberValue;
  return trimmed;
}

function normalizeRole(role) {
  if (role === "plant_head") return "plant_head";
  if (role === "manager") return "manager";
  if (role === "supervisor") return "supervisor";
  if (role === "worker") return "shift_incharge";
  return "shift_incharge";
}

function convertEmployees() {
  const users = {};
  const departments = {};
  const rows = employeesSql
    .split(/\r?\n/)
    .filter((line) => line.trim().startsWith("('VFL"));

  for (const line of rows) {
    const values = splitSqlTuple(line.replace(/,\s*$/, ""));
    const [empCode, name, department, designation, legacyRole, category, salaryType, grossSalary, active] = values;
    if (!empCode || !name) continue;

    const normalizedRole = normalizeRole(String(legacyRole));
    users[empCode] = {
      emp_code: empCode,
      name,
      phone: "",
      role: normalizedRole,
      legacy_role: legacyRole,
      department,
      designation,
      shift_id: "general",
      reporting_manager_emp_code: "",
      active: active === true,
      category,
      salary_type_reference_only: salaryType,
    };

    if (department) {
      const departmentId = String(department).toLowerCase().replace(/[^a-z0-9]+/g, "_").replace(/^_|_$/g, "");
      departments[departmentId] = {
        department_id: departmentId,
        name: department,
        active: true,
        manager_emp_code: "",
        plant_head_emp_code: "",
      };
    }
  }

  writeJson("users_from_active_109.json", { users });
  writeJson("departments_from_active_109.json", { departments });
}

function convertKrasAndKpis() {
  const roleKras = {};
  const roleKpis = {};
  const kraLines = kraSql
    .split(/\r?\n/)
    .filter((line) => /^'(worker|supervisor|manager|plant_head)'/.test(line.trim().slice(1)));

  for (const raw of kraSql.split(/\r?\n/)) {
    const line = raw.trim().replace(/,\s*$/, "");
    if (!line.startsWith("('worker'") && !line.startsWith("('supervisor'") && !line.startsWith("('manager'") && !line.startsWith("('plant_head'")) continue;
    const values = splitSqlTuple(line);
    if (values.length === 6) {
      const [role, kraNumber, title, titleHi, description, weightPct] = values;
      const mappedRole = role === "worker" ? "shift_incharge" : role;
      const id = `${mappedRole}_${kraNumber}_${slug(title)}`;
      roleKras[id] = {
        kra_id: id,
        role: mappedRole,
        legacy_role: role,
        kra_number: kraNumber,
        title,
        title_hi: titleHi,
        description,
        weight_pct: weightPct,
        active: !String(title).toLowerCase().includes("leave"),
      };
    }
    if (values.length === 11) {
      const [role, kraNumber, title, titleHi, targetValue, targetOperator, unit, frequency, weightPct, penaltyPct, autoCalculated] = values;
      const mappedRole = role === "worker" ? "shift_incharge" : role;
      const id = `${mappedRole}_${kraNumber}_${slug(title)}`;
      roleKpis[id] = {
        kpi_id: id,
        role: mappedRole,
        legacy_role: role,
        kra_number: kraNumber,
        title,
        title_hi: titleHi,
        target_value: targetValue,
        target_operator: targetOperator,
        unit,
        frequency,
        weight_pct: weightPct,
        penalty_pct: penaltyPct,
        auto_calculated: autoCalculated === true,
        active: !String(title).toLowerCase().includes("leave"),
      };
    }
  }

  writeJson("role_kras_from_sql.json", { role_kras: roleKras });
  writeJson("role_kpis_from_sql.json", { role_kpis: roleKpis });
}

function slug(value) {
  return String(value)
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "_")
    .replace(/^_|_$/g, "")
    .slice(0, 60);
}

function writeJson(name, data) {
  fs.writeFileSync(path.join(outDir, name), `${JSON.stringify(data, null, 2)}\n`);
}

convertEmployees();
convertKrasAndKpis();
