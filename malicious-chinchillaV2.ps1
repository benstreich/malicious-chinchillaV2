function mc:pw/U{
param ($array, [int]$range, [bool]$specChar, [string]$path)
        
        foreach($a in $array)
        {
            $name += "+" + $a
        }

        $fileName = "!_Comb${name}&${range}&SpecChar${specChar}.txt"
        $completePath = "${path}\${fileName}"

        New-Item -Path $path -ItemType "file" -Name $fileName

        Start-Transcript -Path $completePath -Append 

    try {

        
        function mc:pw{
            param(
                [System.Collections.ArrayList]$keywords,   
                [int]$numbers
                ,[bool]$specialCharacters
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

                 foreach($allCombination in $tempallComb)
                 {
                     $array = @()
                     for($i = $allCombination.Length;$i -gt 0; $i--)
                     {
                        $array += $allCombination[$i-1] 
                     }
                     
                     $allCombinations += (($array -join('')))
                     
                 }

                 $keywords = $allCombinations
            }


            else
            {
               $keywords += ([regex]::Matches($keywords[0],'.','RightToLeft') | ForEach {$_.value}) -join ''
            }
           


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
                                    for($u = 0; $u -le $currentCombination.Length; $u++)
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
    

        mc:pw $array $range $specChar
        
    } catch {
        Write-Error "An error occurred: $_"
    } finally {
        Stop-Transcript
    }




    $content = Get-Content $completePath | Select-Object -Skip 19

    $lineCount = $content.Count - 4

    $content = $content | Select-Object -First $lineCount

    $content | Set-Content $completePath

}


[string]$cmd = Read-Host '~!' 

if($cmd -like "*;*")
{
    $specialcharacters = $false
    $number = 0
    
    if($cmd -like "*-sc*")
    {
        $specialcharacters = $true
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


    mc:pw/U $keywords $number $specialcharacters $path

}
else
{
    Write-Host "The input format is incorrect. Please ensure it follows the 'keyword,keyword; -sc -n{number} -p{path}' format."
}
