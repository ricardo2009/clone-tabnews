import database from "infra/database.js";
import { validateConfig } from "next/dist/server/config-shared";

async function status(request, response) {
  const updatedAt = new Date().toISOString();
  const { rows } = await database.query("SELECT version() AS version");
  const versionPostgres = rows[0].version;
  response.status(200).json({
    updated_at: updatedAt,
    status: true,
    Postgres: versionPostgres,
  });
}

export default status;
