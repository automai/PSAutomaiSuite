Describe "General Commandlet Tests" {
    
    BeforeAll {
        Import-Module "$PSScriptRoot\..\PSAutomaiSuite.psm1"
    }

    Context "Connection Check" {
        It "Check the Automai Connect Command works properly" {
            Mock -CommandName Connect-Automai -MockWith { Import-Clixml "Connect-Automai.xml" }
        }        
    }

    Context "Gets a job Status" {
        It "Mocks getting information about a job" {
            Mock -CommandName Get-JobStatus -MockWith { Import-Clixml "Get-JobStatus.xml" }
        }
    }    

    Context "Sets a schedules Status" {
        It "Mocks schedule status amend" {
            Mock -CommandName Set-Schedule -MockWith { Import-Clixml "Set-Schedule.xml" }
        }
    }
}

Describe "Loader Tests" {

    BeforeAll {
        Import-Module "$PSScriptRoot\..\PSAutomaiSuite.psm1"
    }

    Context "Get a performance testing plan current run status" {
        It "Mocks the process or getting the status of a loader run" {
            Mock -CommandName Get-LoaderPlan -MockWith { Import-Clixml "Get-LoaderPlan.xml" }
        }    
    }

    Context "Generate a performance testing report" {
        It "Mocks the process of generating a URL for a report plan" {
            Mock -CommandName Get-LoaderReport -MockWith { Import-Clixml "Get-LoaderReport_Detailed.xml" }
        }    
    }

    Context "Generate a performance testing report" {
        It "Mocks the process of generating a URL for a report plan" {
            Mock -CommandName Get-LoaderReport -MockWith { Import-Clixml "Get-LoaderReport_Raw.xml" }
        }    
    }

    Context "Generate a performance testing report" {
        It "Mocks the process of generating a URL for a report plan" {
            Mock -CommandName Get-LoaderReport -MockWith { Import-Clixml "Get-LoaderReport_Summary.xml" }
        }    
    }

    Context "Generate a performance testing report" {
        It "Mocks the process of generating a URL for a report plan" {
            Mock -CommandName Get-LoaderReport -MockWith { Import-Clixml "Get-LoaderReport_Transaction.xml" }
        }    
    }

    Context "Check the number of rLoader users" {
        It "Mocks the process of checking the number of rLoader users running" {
            Mock -CommandName Get-LoaderUsers -MockWith { Import-Clixml "Get-LoaderUsers.xml" }
        }    
    }

    Context "Start a loader plan" {
        It "Mocks the process of starting a loader plan" {
            Mock -CommandName Play-LoaderPlan -MockWith { Import-Clixml "Play-LoaderPlan.xml" }
        }    
    }

    Context "Starts rLoader users" {
        It "Mocks the process of starting rloader users" {
            Mock -CommandName Start-LoaderUsers -MockWith { Import-Clixml "Start-LoaderUsers.xml" }
        }    
    }

    #Context "Stops a Loader plan" {
    #    It "Mocks the process of stopping an Loader plan" {
    #        Mock -CommandName Stop-LoaderPlan -MockWith { Import-Clixml "$PSScriptRoot\Stop-LoaderPlan.xml" }
    #    }    
    #}
}

Describe "Watcher Tests" {

    BeforeAll {
        Import-Module "$PSScriptRoot\..\PSAutomaiSuite.psm1"
    }

    Context "Gets Watcher result data in raw format" {
        It "Mocks the process or getting the Watcher results data" {
            Mock -CommandName Get-WatcherData -MockWith { Import-Clixml "Get-WatcherData.xml" }
        }    
    }
}

Describe "Tester Tests" {

    BeforeAll {
        Import-Module "$PSScriptRoot\..\PSAutomaiSuite.psm1"
    }

    #Context "Plays a tester/worker flow" {
    #    It "Mocks the process or starting a tester/worker flow" {
    #        Mock -CommandName Play-WorkerTesterFlow -MockWith { Import-Clixml "Play-WorkerTesterFlow.xml" }
    #    }    
    #}

    #Context "Stops a tester/worker flow" {
    #    It "Mocks the process or stopping a tester/worker flow" {
    #        Mock -CommandName Stop-WorkerTesterFlow -MockWith { Import-Clixml "Stop-WorkerTesterFlow.xml" }
    #    }    
    #}
}