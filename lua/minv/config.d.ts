export declare type LogLevel = "DEBUG" | "INFO" | "WARN" | "ERROR";
export interface Config {
    log: {
        level: LogLevel;
    };
}
export declare const CONFIG: Config;
