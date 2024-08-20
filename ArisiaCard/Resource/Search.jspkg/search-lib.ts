/*
 * search-lib.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/search.frame.d.ts"/>

class GoogleLauncher
{
	table:		site_list_TableIF ;
	keyword:	string ;
	site_type:	string ;
	site:		string | null;

	constructor(tbl: site_list_TableIF) {
		this.table	= tbl ;
		this.keyword	= "" ;
		this.site_type	= "related:" ;
		this.site	= null ;
	}

	set_keyword(word: string){
		this.keyword = word ;
	}

	set_site_type(type: string) {
		this.site_type = type ;
	}

	set_site(site: string | null){
		this.site = site ;
	}

	launch(){
		let target  = "https://www.google.com/search?" ;
		let sites   = "" ;
		if(this.site != null){
			let type = this.site_type ;
			let recs = this.table.select("name", this.site) ;
			if(recs.length > 0){
				sites += " " + type + recs[0].url ;
			}
		}
		let input   = target
			    + "q=" + this.keyword
			    + sites
			    ;
		console.log("SEARCH: " + input) ;
		openURL(input) ;
	}
}

function collectSiteNames(sites: site_list_TableIF): MenuItemIF[]
{
	/* collect category names */
	let names = new Set<string>() ;
	for(const rec of sites.records()){
		names.add(rec.name) ;
	}
	let items: MenuItemIF[] = [
		MenuItem("none", 0)
	] ;
	let num:   number = 1 ;
	for(const cat of names){
		items.push(MenuItem(cat, num)) ;
		num += 1 ;
	}
	return items ;
}

