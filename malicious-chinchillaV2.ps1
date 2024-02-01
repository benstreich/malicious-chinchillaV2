function mc:pw/U{
param ($array, [int]$range, [bool]$specChar, [string]$path, [bool]$reverse)
        
        foreach($a in $array)
        {
            $name += "+" + $a
        }

        $fileName = "!_Comb${name}&${range}&SpecChar${specChar}&Reversed${reverse}.txt"
        $completePath = "${path}\${fileName}"

        New-Item -Path $path -ItemType "file" -Name $fileName


    try {

        
       function mc:pw{
            param(
                [System.Collections.ArrayList]$keywords,   
                [int]$numbers
                ,[bool]$specialCharacters,
                [bool]$reversed
            )

            if($keywords.Count -gt 1)
            {

                function Get-KeywordCombinations {
                                param (
                                    [string[]]$keywords,
                                    [string]$currentCombination = '',
                                    [System.Collections.ArrayList]$allCombinations
                                )
                            
                                foreach ($keyword in $keywords) {
                                    $newCombination = $currentCombination + $keyword
                                    
                                    $allCombinations.Add($newCombination) | Out-Null
                                    
                                    $remainingKeywords = $keywords | Where-Object { $_ -ne $keyword }
                                    
                                    Get-KeywordCombinations -keywords $remainingKeywords -currentCombination $newCombination -allCombinations $allCombinations
                                }
                            }

                $allCombinations = New-Object System.Collections.ArrayList  
                
                Get-KeywordCombinations -keywords $keywords -allCombinations $allCombinations
                
                $allCombinations = $allCombinations | Sort-Object | Get-Unique 

                 $tempallComb = $allCombinations

                 if($reversed -eq $true)
                 {

                 foreach($allCombination in $tempallComb)
                 {
                     $array = @()
                     for($i = $allCombination.Length;$i -gt 0; $i--)
                     {
                        $array += $allCombination[$i-1] 
                     }
                     
                     $allCombinations += (($array -join('')))
                     
                 }
                 }

                 $keywords = $allCombinations
            }


            else
            {
                if($reversed -eq $true){
               $keywords += ([regex]::Matches($keywords[0],'.','RightToLeft') | ForEach {$_.value}) -join ''}
            }
           

           foreach($keyword in $keywords)
           {
                [int]$len = $keyword.Length

                #only upper/lower comb
                $ulCase = [Math]::Pow(2, $len)
                $combinationsCalc += $ulCase

                Write-host "Only Upper/Lowercase: keyword($keyword), Possibilities($ulCase)"
                

                #upper/lower + numbers at every index
                if($numbers -ne 0)
                {
                    $ulCaseN = (([Math]::Pow(2, $len)) * ($len + 1)) * ($numbers + 1)
                    $combinationsCalc += $ulCaseN
                    Write-host "Upper/Lowercase + numbers at every index: keyword($keyword), Possibilities($ulCaseN)"
                }

                #upper/lower + special characters at every index
                if($specChar -eq $true)
                {
                    $ulCaseSC = ([Math]::Pow(2, $len) * ($len + 1)) * 19
                    $combinationsCalc += $ulCaseSC
                    Write-host "Upper/Lowercase + specialcharacters at every index: keyword($keyword), Possibilities($ulCaseSC)"
                }

                #upper/lower + special characters at every index + numbers at every index
                if($specChar -eq $true -and $numbers -ne 0)
                {
                    $ulCaseNSC = (((($len+2) * 19) * ($len+1)) * ($numbers+1)) * ([Math]::Pow(2, $len))
                    $combinationsCalc += $ulCaseNSC
                    Write-host "Upper/Lowercase + numbers at every index + specialcharacters at every index: keyword($keyword), Possibilities($ulCaseNSC)"
                }

                Write-host "`n"

           }

           Write-host "Total possible Combinations:" $combinationsCalc
           $estTime = ($combinationsCalc / 22) / 1000
           Write-host "Estimated Time: ${estTime}s"



                #every lower/upper case combination 
                #foreach combination of keywords
                foreach($keyword in $keywords)
                {
                 
                    function GenerateCombinations($inputString, $currentIndex = 0, $currentCombination = "") {
                        if ($currentIndex -eq $inputString.Length) {
                               $currentCombination 
                            
                            return
                        }
                    
                            $lowerChar = $inputString.Substring($currentIndex, 1).ToLower()
                            $upperChar = $inputString.Substring($currentIndex, 1).ToUpper()
                    
                            GenerateCombinations $inputString ($currentIndex + 1) ($currentCombination + $lowerChar)
                            GenerateCombinations $inputString ($currentIndex + 1) ($currentCombination + $upperChar)
                        }
                    
                    GenerateCombinations $keyword

                }

                #every lower/upper case combination 
                #foreach combination of keywords
                #with foreach the provided numbers in each index of the string
                if($numbers -ne 0)
                {
                    foreach($keyword in $keywords)
                    {
                     
                    function GenerateCombinations($inputString, $currentIndex = 0, $currentCombination = "") {
                        if ($currentIndex -eq $inputString.Length) {
                            

                            for ($k = 0; $k -le $numbers; $k++) {

                                for ($z = 0; $z -le $currentCombination.Length; $z++) {
                                    $currentCombination.Insert($z, $k.ToString()) 
                                    
                                }
                            }
                            
                            return
                        }
                    
                            $lowerChar = $inputString.Substring($currentIndex, 1).ToLower()
                            $upperChar = $inputString.Substring($currentIndex, 1).ToUpper()
                    
                            GenerateCombinations $inputString ($currentIndex + 1) ($currentCombination + $lowerChar)
                            GenerateCombinations $inputString ($currentIndex + 1) ($currentCombination + $upperChar)
                        }
                    
                    GenerateCombinations $keyword

                }
                }    
                         
                #every lower/upper case combination 
                #foreach combination of keywords
                #with foreach specialcharacter in each index of the string
                if($specialCharacters -eq $true)
                {
                    foreach($keyword in $keywords)
                    {
                        function GenerateCombinations($inputString, $currentIndex = 0, $currentCombination = "") {
                        if ($currentIndex -eq $inputString.Length) {
                            
                    
                            $specialcharacteres = @('!', '?', '$', '^', '+', '-', '#', '{', '}', '[', ']', '/', '\', '*', '(', ')', '%', '&', '~')
                    
                            foreach($sp in $specialcharacteres)
                            {
                                for($z = 0; $z -le $currentCombination.Length; $z++)
                                {
                                    $currentCombination.Insert($z, $sp.ToString()) 
                                }
                                
                            }
                            return
                        }
                    
                        $lowerChar = $inputString.Substring($currentIndex, 1).ToLower()
                        $upperChar = $inputString.Substring($currentIndex, 1).ToUpper()
                    
                        GenerateCombinations $inputString ($currentIndex + 1) ($currentCombination + $lowerChar)
                        GenerateCombinations $inputString ($currentIndex + 1) ($currentCombination + $upperChar)
                    }

                        GenerateCombinations $keyword
                    }
                }
                

                #every lower/upper case combination
                #foreach combination of keywords
                #with foreach number at every index with every possible specialcharacter combination at every single index
                if($specialCharacters -eq $true -and $numbers -ne 0)
                {
                    
                    foreach($keyword in $keywords)
                    {
                        function GenerateCombinations($inputString, $currentIndex = 0, $currentCombination = "") {
                        if ($currentIndex -eq $inputString.Length) {
                        $specialcharacteres = @('!', '?', '$', '^', '+', '-', '#', '{', '}', '[', ']', '/', '\', '*', '(', ')', '%', '&', '~')

                        for($i = 0; $i -le $numbers; $i++)
                        {
                            
                            for($z = 0; $z -le $currentCombination.Length; $z++)
                            {
                                $curCom = $currentCombination.Insert($z, $i.ToString())

                                foreach($sp in $specialcharacteres)
                                {
                                    for($u = 0; $u -le $currentCombination.Length + 1; $u++)
                                    {
                                        $curCom.Insert($u, $sp.ToString()) 
                                    }
                                
                                }
                            }
                        }
    
       
                                return
                            }
                        
                            $lowerChar = $inputString.Substring($currentIndex, 1).ToLower()
                            $upperChar = $inputString.Substring($currentIndex, 1).ToUpper()
                        
                            GenerateCombinations $inputString ($currentIndex + 1) ($currentCombination + $lowerChar)
                            GenerateCombinations $inputString ($currentIndex + 1) ($currentCombination + $upperChar)
                        }

                        GenerateCombinations $keyword
                    }

                }
      }
    

        (mc:pw $array $range $specChar $reverse) | Out-File -FilePath $completePath
        
    } catch {
        Write-Error "An error occurred: $_"
    } 

}


[string]$cmd = Read-Host '~!' 

if($cmd -like "*;*")
{
    $specialcharacters = $false
    $number = 0
    $reverse = $false


    if($cmd -like "*-sc*")
    {
        $specialcharacters = $true
    }
    if($cmd -like "*-rv*")
    {
        $reverse = $true          
    }

    if($cmd -match "-p(\S+)")
    {
        $path = [string]$Matches[1]
       
    }

    elseif($cmd -notmatch "-p(\S+)")
    {
        "Please provide a path using -p{path}"
        break
    }

    if($cmd -match '-n(\d+)')
    {
        $number = [int]$Matches[1]
    }

    $parts = $cmd -split ';'


    $keywordsPart = $parts[0].Trim()
    
    if($keywordsPart -like "*,*")
    {
        $keywords = $keywordsPart -split ',' | ForEach-Object { $_.Trim() }
    }

    else
    {
        $keywords = [array]$keywordsPart
    }


    mc:pw/U $keywords $number $specialcharacters $path $reverse

}
else
{
    Write-Host "The input format is incorrect. Please ensure it follows the 'keyword,keyword; -sc -n{number} -p{path}' format."
}
