
Describe "Search-Process" {
    It "Executes a search query against Carbon Black EDR and retrieves results" {

        # Search query
        $ProcessSearchResult = Search-Process -Query "process_name:*" -Rows 10
        $ProcessSearchResult | Should -Not -BeNullOrEmpty
        $ProcessSearchResult.results.count | Should -BeGreaterThan 0

        ##
        ## Validate returned object
        ##


        # Search query - results only
        $ProcessSearchResultsOnly = Search-Process -Query "process_name:*" -Rows 10 -ResultsOnly
        $ProcessSearchResultsOnly | Should -Not -BeNullOrEmpty
        $ProcessSearchResultsOnly.count | Should -BeGreaterThan 0

        ##
        ## Validate returned object
        ##


        # Search for 1 result
        $ProcessSearchResultsOnly = Search-Process -Query "process_name:*" -Rows 1 -ResultsOnly
        $ProcessSearchResultsOnly | Should -Not -BeNullOrEmpty
        $ProcessSearchResultsOnly.count | Should -BeNullOrEmpty

        # Search for 10000 results
        $ProcessSearchResultsOnly = Search-Process -Query "process_name:*" -Rows 10000 -ResultsOnly
        $ProcessSearchResultsOnly | Should -Not -BeNullOrEmpty
        $ProcessSearchResultsOnly.count | Should -Be 10000

        # Validate results from a specific query
        $ProcessSearchSpecific = Search-Process -Query "process_name:bash" -Rows 10 -ResultsOnly
        $ProcessSearchSpecific | Should -Not -BeNullOrEmpty
        $ProcessSearchSpecific.count | Should -Be 10
        foreach ($Process in $ProcessSearchSpecific) {
            $Process.process_name | Should -Be "bash"
        }

        # Validate results from a leading wildcard query
        $ProcessSearchSpecific = Search-Process -Query "process_name:*ash" -Rows 10 -ResultsOnly
        $ProcessSearchSpecific | Should -Not -BeNullOrEmpty
        $ProcessSearchSpecific.count | Should -Be 10
        foreach ($Process in $ProcessSearchSpecific) {
            $Process.process_name | Should -Be "bash"
        }

        # Validate results from a middle-wildcard query
        $ProcessSearchSpecific = Search-Process -Query "process_name:ba*h" -Rows 10 -ResultsOnly
        $ProcessSearchSpecific | Should -Not -BeNullOrEmpty
        $ProcessSearchSpecific.count | Should -Be 10
        foreach ($Process in $ProcessSearchSpecific) {
            $Process.process_name | Should -Be "bash"
        }

        # Validate results from a trailing-wildcard query
        $ProcessSearchSpecific = Search-Process -Query "process_name:bas*" -Rows 10 -ResultsOnly
        $ProcessSearchSpecific | Should -Not -BeNullOrEmpty
        $ProcessSearchSpecific.count | Should -Be 10
        foreach ($Process in $ProcessSearchSpecific) {
            $Process.process_name | Should -Be "bash"
        }

        ##
        ## Test the "start" parameter some how
        ##

        ##
        ## Test the "sort" parameter
        ##
        $ProcessSearchResult = Search-Process -Query "process_name:*" -Rows 5 -Sort "last_update asc"
        $ProcessSearchResult | Should -Not -BeNullOrEmpty
        $ProcessSearchResult.results.count | Should -Be 5

        for ($i=0; $i -lt $ProcessSearchResult.results.count; $i++) {
            $LastUpdateTime = $ProcessSearchResult.results[$i].last_update | ConvertTo-DateTime
            if ($i -ne 0) {
                $LastUpdateTime | Should -BeGreaterOrEqual $Previous
            }
            $Previous = $LastUpdateTime
        }

        ##
        ## Test the "facet" parameter
        ##
        $ProcessSearchResult = Search-Process -Query "process_name:*" -Rows 5 -Facet $true
        $ProcessSearchResult | Should -Not -BeNullOrEmpty
        $ProcessSearchResult.results.count | Should -Be 5
        $ProcessSearchResult.facets.PSobject.Properties.Name.count | Should -BeGreaterOrEqual 1
        $ProcessSearchResult.facets.process_name | Should -Not -BeNullOrEmpty
        $ProcessSearchResult.facets.process_name.count | Should -BeGreaterThan 0

        ##
        ## Test the "facet field" parameter
        ##
        $ProcessSearchResult = Search-Process -Query "process_name:*" -Rows 5 -Facet $true -FacetField "username_full"
        $ProcessSearchResult | Should -Not -BeNullOrEmpty
        $ProcessSearchResult.results.count | Should -Be 5
        $ProcessSearchResult.facets.PSobject.Properties.Name.count | Should -Not -BeNullOrEmpty
        $ProcessSearchResult.facets.process_name | Should -BeNullOrEmpty
        $ProcessSearchResult.facets.process_name.count | Should -Be 0
        $ProcessSearchResult.facets.username_full | Should -Not -BeNullOrEmpty
        $ProcessSearchResult.facets.username_full.count | Should -BeGreaterThan 0

        ##
        ## Test the "ComprehensiveSearch" parameter
        ##

        ##
        ## Test the "FuzzyFacet" parameter
        ##

        ##
        ## Test the "Group" parameter
        ##

    }
}
