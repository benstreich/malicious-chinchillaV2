function mc:pw/U{
param ($array, [int]$range, [int]$specChar, [string]$path, [bool]$reverse, [int]$dic, [bool]$combinationKeywords)


        if($dic -ne 0)
        {
            try 
            {
                $response = Invoke-WebRequest -Uri www.google.com -TimeoutSec 5 -ErrorAction Stop
               
            }
            catch {
                "Internet connection is not available. Please connect to the internet to use this feature"
                break
            }

            $temparray = $array
           
            foreach($a in $array)
            {
                 $request = Invoke-RestMethod -uri "https://api.datamuse.com/words?ml=$a"
                 $temparray += $request[0..($dic-1)].word
            }
            
            $array = $temparray
        }





        foreach($a in $array)
        {
            $name += "+" + $a
        }

        $fileName = "!_maliciouschinchillav2${name}&Combination${combinationKeywords}&Range${range}&SpecChar${specChar}&Reversed${reverse}.txt"
        $completePath = "${path}\${fileName}"

        New-Item -Path $path -ItemType "file" -Name $fileName


    try {

        
       function mc:pw{
            param(
                [System.Collections.ArrayList]$keywords,   
                [int]$numbers
                ,[int]$specialCharacters,
                [bool]$reversed
                ,[bool]$combinationKeywords
            )




            if($combinationKeywords -eq $true)
            {

                #foundationstone Keywords
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
            } 


           #CombinationsCalculations
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
                if($specialCharacters -ne 0)
                {
                    if($specialCharacters -eq 1)
                    {
                        $ulCaseSC = ([Math]::Pow(2, $len) * ($len + 1)) * 19
                        $combinationsCalc += $ulCaseSC
                        Write-host "Upper/Lowercase + specialcharacters at every index: keyword($keyword), Possibilities($ulCaseSC)"
                    }
                    if($specialCharacters -eq 2)
                    {
                        $ulCaseMSC = (((($len+2) * 19) * ($len+1)) * (19)) * ([Math]::Pow(2, $len))
                        $combinationsCalc += $ulCaseMSC
                        Write-host "Upper/Lowercase + 2 specialcharacters at every index: keyword($keyword), POssibilites($ulCaseMSC)"
                    }
                    
                }

                #upper/lower + special characters at every index + numbers at every index
                if($specialCharacters -ne 0 -and $numbers -ne 0)
                {
                    if($specialCharacters -eq 1)
                    {
                        $ulCaseNSC = (((($len+2) * 19) * ($len+1)) * ($numbers+1)) * ([Math]::Pow(2, $len))
                        $combinationsCalc += $ulCaseNSC
                        Write-host "Upper/Lowercase + numbers at every index + specialcharacters at every index: keyword($keyword), Possibilities($ulCaseNSC)"
                    }
                    elseif($specialCharacters -eq 2)
                    {
                        $ulCaseNMSC = (((((($len+3) * 19) * ($len + 2)) * 19) * ($len+1)) * ($numbers + 1)) * ([Math]::Pow(2, $len))
                        $combinationsCalc += $ulCaseNMSC
                        Write-Host "Upper/Lowercase + numbers at every index + specialcharacters (multiple) at every index: keyword($keyword), Possibilities($ulCaseNMSC)"
                    }
                }

                Write-host "`n"

           }

           Write-host "Total possible Combinations:" $combinationsCalc
           $estTime = [Math]::Round((($combinationsCalc / 22) / 1000),2)
           if($estTime -gt 60)
           { 
                $estTime = $estTime / 60
                Write-host "Estimated Time: ${estTime}m"
           }
           if($estTime -gt 3600)
           {
                $estTime = $estTime / 3600
                Write-Host "Estimated Time: ${estTime}h"
           }
            else
           {
                Write-host "Estimated Time: ${estTime}s"
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
                if($specialCharacters -ne 0)
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
                                    if($specialCharacters -eq 1)
                                    {  
                                        $currentCombination.Insert($z, $sp.ToString()) 
                                    }

                                    if($specialCharacters -eq 2){                           

                                        $curComb = $currentCombination.Insert($z, $sp.ToString()) 

                                        foreach($spc in $specialcharacteres)
                                        {
                                            for($u = 0; $u -le ($currentCombination.Length + 1); $u++)
                                            {
                                                $curComb.Insert($u, $spc.ToString())
                                            }
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
                

                #every lower/upper case combination
                #foreach combination of keywords
                #with foreach number at every index with every possible specialcharacter combination at every single index
                if($specialCharacters -ne 0 -and $numbers -ne 0)
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
                                        if($specialCharacters -eq 1)
                                        {
                                            $curCom.Insert($u, $sp.ToString()) 
                                        }
                                        elseif($specialCharacters -eq 2)
                                        {
                                              $curComb = $curCom.Insert($u, $sp.ToString()) 

                                               foreach($spc in $specialcharacteres)
                                               {
                                                   for($c = 0; $c -le ($currentCombination.Length + 2); $c++)
                                                   {
                                                       $curComb.Insert($c, $spc.ToString())
                                                   }
                                               }
                                        }

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
    

        (mc:pw $array $range $specChar $reverse $combinationKeywords) | Out-File -FilePath $completePath
        
    } catch {
         Write-Host "An error occurred" -ForegroundColor "Red"

         Write-Error $_
    } 

}




[string]$cmd = Read-Host '~!' 

if($cmd -like "*;*")
{
    $number = 0
    $reverse = $false
    $numSC = 0
    $dic = 0
    $combinationKeywords = $false

    if($cmd -match '-sc(\d+)')
    {
        $numSC = [int]$Matches[1]

        if($numSC -ne 1 -and $numSC -ne 2)
        {
            Write-Host "Please provide a number between one and two using -sc[1/2]"
            break
        }

    }


    $e = $cmd -split ' '

    if($e -contains '-c')
    {
        $combinationKeywords = $true
    }

    if($e -contains "-rv")
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

    if($cmd -match '-d(\d+)')
    {
         $dic = [int]$Matches[1]
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


    mc:pw/U $keywords $number $numSC $path $reverse $dic $combinationKeywords





}

else
{
    Write-Host "The input format is incorrect. Please ensure it follows this format:
    ~!: keyword,keyword;
    [MANDATORY][-p [string]Path] [--path]
    [-sc[int]1 || [int]2] [--specialcharacters[int]1 || [int]2]
    [-rv] [--reverse]
    [-n[int]] [--number[int]]
    [INTERNET CONNECTION REQUIRED][-d[int]] [--dictionary[int]]
    [-c] [--combination]"
}



