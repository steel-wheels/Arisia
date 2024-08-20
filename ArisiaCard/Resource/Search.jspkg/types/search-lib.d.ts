/// <reference path="ArisiaPlatform.d.ts" />
/// <reference path="search.frame.d.ts" />
declare class GoogleLauncher {
    table: site_list_TableIF;
    keyword: string;
    site_type: string;
    site: string | null;
    constructor(tbl: site_list_TableIF);
    set_keyword(word: string): void;
    set_site_type(type: string): void;
    set_site(site: string | null): void;
    launch(): void;
}
declare function collectSiteNames(sites: site_list_TableIF): MenuItemIF[];
