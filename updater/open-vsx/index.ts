import { log } from "../deps.ts"
import * as nixUtils from "../utils/nix.ts"
import * as openVSXAPI from "./api.ts"

export async function getEntries() {
	log.info("Fetching data from OpenVSX API...")
	const { count, data } = await openVSXAPI.getExtensionsData()
	log.info("Fetched data from OpenVSX API.")
	log.info(`${count} extensions found.`)

	log.info("Generating entries...")
	const entries = data.filter(filterPlatformDependent).map(e => ({
		name: e.name,
		publisher: e.namespace,
		passthru: {
			name: nixUtils.toValidNixIdentifier(e.name),
			publisher: nixUtils.toValidNixIdentifier(e.namespace),
			marketplaceName: e.name,
			marketplacePublisher: e.namespace,
			license: nixUtils.toNixpkgsLicense(e.license),
			changelog: e.files.changelog,
			downloadPage: e.files.download,
			homepage: e.homepage
		}
	})).map(e => [`${e.publisher}-${e.name}`, {
		src: `${e.publisher}.${e.name}`,
		fetch: `${e.publisher}.${e.name}`,
		passthru: e.passthru
	}])
	log.info("Generated entries.")

	return entries
}


function filterPlatformDependent(e) {
	// e.g
	// universal: https://open-vsx.org/api/zjffun/snippetsmanager?size=1
	// platform-dependent: https://open-vsx.org/api/devsense/phptools-vscode?size=1
	return 'universal' in e.downloads;
}