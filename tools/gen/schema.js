#!/usr/bin/env node

import { FetchingJSONSchemaStore, InputData, JSONSchemaInput, quicktype } from "quicktype-core";
import { join, dirname } from "node:path";
import { exists, mkdir, writeFileSync } from "node:fs";
import { execSync } from "node:child_process";

import copyright from "../shared/copyright.js";
import { exit } from "node:process";

/**
 * Generates Dart Object File from the generated schema
 * @param {string} language 
 * @param {string} name 
 * @param {string} schema 
 * @param {string} confName
 * @param {boolean} [debug=false]
 */
async function generateFromJSONSchema(language, name, confName, schema, debug = false) {
    const schemaInput = new JSONSchemaInput(new FetchingJSONSchemaStore());

    await schemaInput.addSource({
        name, 
        schema,
    });

    const inputData = new InputData();
    inputData.addInput(schemaInput);

    return await quicktype({
        inputData,
        lang: language,
        debugPrintSchemaResolving: debug,
        debugPrintGraph: debug,
        leadingComments: [
            "This file contains configuration for the Spurte Configuration. For more information, see https://github.com/spurte/schema",
            "ignore_for_file: constant_identifier_names"
        ],
        rendererOptions: {
            "null-safety": true,
            "final-props": true,
            "use-json-annotation": true,
            "part-name": confName
        }
    })
}

async function main() {
    /** @type {string} */
    const pkg = join(process.cwd(), "packages", "spurte");
    const pkgConfig = join(pkg, "lib", "src", "schema", "config.dart");

    console.log("Fetching schema");
    const config = await fetch("https://spurte.github.io/schema/dart/openapi.json").then(async v => await v.text());

    console.log("Parsing Schema");
    await generateFromJSONSchema('dart', 'SpurteConfig', 'config', config).then((c) => {
        const { lines } = c;
        
        let code = lines.join("\n");
        code = `${copyright}\n${code}`;

        // write config to output file
        console.log("Writing configuration to file");
        exists(pkgConfig, function (exists) {
            if (!exists) mkdir(dirname(pkgConfig), { recursive: true }, (err, path) => {
                if (err) {
                    console.error("Error creating output file: ", err);
                    exit(1);
                }
            })
        });

        writeFileSync(pkgConfig, code);

        // run build_runner
        console.log("Running build_runner")
        const output = execSync("dart run build_runner build --delete-conflicting-outputs", { cwd: pkg, encoding: 'utf8' });

        console.log("Done! Configuration written to", pkgConfig);
    });
}

main();