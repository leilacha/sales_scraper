
### Sales Scraper

*Scraper of 2 websites*

#### Global Industries
https://global-industrie.com/fr/liste-des-exposants

1/ Launch `GetCompaniesNames` to fetch all companies names (output file: "interactors/global_industries/companies_names.txt")
2/ Launch `GlobalIndustries.new.scrape`

    ruby global_industries.rb

It's reading "companies_names.txt" file and for each company, searching the company in the search bar, click on the result, scrap the company page

#### Be positive
https://www.bepositive-events.com/fr/liste-exposants

1/ Launch `BepositiveUrls.new.scrape` to fetch company name + bepositive company url (output file: "bepositive_company_urls.csv")

    ruby bepositive_urls.rb

2/ Launch `BepositiveScraper.new.scrape`

    ruby bepositive_scraper.rb

It is reading "bepositive_company_urls.csv" file and for each company, visit bepositive company url and scrap company info
