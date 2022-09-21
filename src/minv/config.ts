export type LogLevel = "DEBUG" | "INFO" | "WARN" | "ERROR";

export interface Config {
  log: { level: LogLevel };
}

export const CONFIG: Config = {
  log: { level: "DEBUG" },
};
