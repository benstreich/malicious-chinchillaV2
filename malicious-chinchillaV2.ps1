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
                 $temparray += $request[0..($dic-1)].word.replace(' ', '')
            }
            
            $array = $temparray
        }

        foreach($a in $array)
        {
            $name += "+" + $a
        }

        $fileName = "!_maliciouschinchillav2${name}&Combination${combinationKeywords}&Range${range}&SpecChar${specChar}&Reversed${reverse}.txt"
        $completePath = "${path}\${fileName}"

        $stream = [System.IO.File]::Open($completePath, [System.IO.FileMode]::Create)

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
                if($keywords.Count -lt 2)
                {
                    cls
                    Write-host "if the flag -c is prompted make sure to use atleast two keywords" 
                    break
                }



                #foundationstone Keywords
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

               
                 $keywords = $allCombinations

            } 

            if($reversed -eq $true)
            {

                 foreach($keyword in $keywords)
                 {
                     $array = @()
                     for($i = $keyword.Length;$i -gt 0; $i--)
                     {
                        $array += $keyword[$i-1] 
                     }
                     
                     $keywords += (($array -join('')))
                     
                 }
              }

           #CombinationsCalculations
           foreach($keyword in $keywords)
           {
                [int]$len = $keyword.Length

                #only upper/lower comb
                $ulCase = [Math]::Pow(2, $len)
                $combinationsCalc += $ulCase

                #upper/lower + numbers at every index
                if($numbers -ne 0)
                {
                    $ulCaseN = (([Math]::Pow(2, $len)) * ($len + 1)) * ($numbers + 1)
                    $combinationsCalc += $ulCaseN
                }

                #upper/lower + special characters at every index
                if($specialCharacters -ne 0)
                {
                    if($specialCharacters -eq 1)
                    {
                        $ulCaseSC = ([Math]::Pow(2, $len) * ($len + 1)) * 19
                        $combinationsCalc += $ulCaseSC
                    }
                    if($specialCharacters -eq 2)
                    {
                        $ulCaseMSC = (((($len+2) * 19) * ($len+1)) * (19)) * ([Math]::Pow(2, $len))
                        $combinationsCalc += $ulCaseMSC
                    }
                    
                }

                #upper/lower + special characters at every index + numbers at every index
                if($specialCharacters -ne 0 -and $numbers -ne 0)
                {
                    if($specialCharacters -eq 1)
                    {
                        $ulCaseNSC = (((($len+2) * 19) * ($len+1)) * ($numbers+1)) * ([Math]::Pow(2, $len))
                        $combinationsCalc += $ulCaseNSC
                    }
                    elseif($specialCharacters -eq 2)
                    {
                        $ulCaseNMSC = (((((($len+3) * 19) * ($len + 2)) * 19) * ($len+1)) * ($numbers + 1)) * ([Math]::Pow(2, $len))
                        $combinationsCalc += $ulCaseNMSC
                    }
                }


           }

           Write-host "`n"

           Write-host "Total possible Combinations: " -NoNewline
           Write-host $combinationsCalc -ForegroundColor Green

           $estTime = [Math]::Round($combinationsCalc / 190224)

           if($estTime -gt 60 -and $estTime -lt 3600)
           {
                $estTimeMIN = $estTime / 60
                Write-host "Estimated Time: " -NoNewline 
                Write-host "${estTimeMIN}m" -ForegroundColor Blue
           }
           elseif($estTime -gt 3600 -and $estTime -lt 86400)
           {
                $estTimeHOUR = $estTime / 3600
                Write-Host "Estimated Time: " -NoNewline
                Write-host "${estTimeHOUR}h" -ForegroundColor Blue
           }
           elseif($estTiem -gt 86400)
           {
                $estTimeDAY = $estTime / 86400
                Write-Host "Estimated Time: " -NoNewline
                Write-host "${estTimeDAY}d" -ForegroundColor Blue
           }
           else
           {
                Write-host "Estimated Time: " -NoNewline
                Write-host "${estTime}s" -ForegroundColor Blue
           }



                #every lower/upper case combination 
                #foreach combination of keywords
                
                $res = foreach($keyword in $keywords)
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

                $data = [System.Text.Encoding]::UTF8.GetBytes($res)

                $result = $stream.BeginWrite($data, 0, $data.Length, $null, $null)
                $stream.EndWrite($result)
                
                

                #every lower/upper case combination 
                #foreach combination of keywords
                #with foreach the provided numbers in each index of the string
                if($numbers -ne 0)
                {
                    $res = foreach($keyword in $keywords)
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
                $data = [System.Text.Encoding]::UTF8.GetBytes($res)

                $result = $stream.BeginWrite($data, 0, $data.Length, $null, $null)
                $stream.EndWrite($result)
                }    
                         
                #every lower/upper case combination 
                #foreach combination of keywords
                #with foreach specialcharacter in each index of the string
                if($specialCharacters -ne 0)
                {
                    $res = foreach($keyword in $keywords)
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

                    $data = [System.Text.Encoding]::UTF8.GetBytes($res)

                    $result = $stream.BeginWrite($data, 0, $data.Length, $null, $null)
                    $stream.EndWrite($result)
                }
                

                #every lower/upper case combination
                #foreach combination of keywords
                #with foreach number at every index with every possible specialcharacter combination at every single index
                if($specialCharacters -ne 0 -and $numbers -ne 0)
                {
                    
                    $res = foreach($keyword in $keywords)
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

                    $data = [System.Text.Encoding]::UTF8.GetBytes($res)

                    $result = $stream.BeginWrite($data, 0, $data.Length, $null, $null)
                    $stream.EndWrite($result)

                }

                $stream.Close()
      }
    
        Measure-Command{
        mc:pw $array $range $specChar $reverse $combinationKeywords
        }

        Write-host "`n"
        Write-Host "Process finished" -ForegroundColor Green
        Start-Sleep -Seconds 15
        
    } catch {
        Write-Host "ERROR" -ForegroundColor Red
        Start-Sleep -Seconds 15

    } 

}

$name = 'malicious-chinchilla.'
$char = $name.ToCharArray()

foreach($c in $char)
{
    Write-host $c -NoNewline -ForegroundColor Red
    Start-Sleep -Milliseconds 40
}
Write-host ""
Start-Sleep -Seconds 1

for($i = 0; $i -lt 5; $i++)
{
    switch($i)
    {
       
        1
        {
            Write-host $name -ForegroundColor Yellow
            Start-Sleep -Milliseconds 100
        }

        2
        {
            Write-host $name -ForegroundColor Green
            Start-Sleep -Milliseconds 100
        }
        3
        {
            Write-host $name -ForegroundColor Blue
            Start-Sleep -Milliseconds 100
        }
        4
        {
            Write-host $name -ForegroundColor DarkBlue
            Start-Sleep -Milliseconds 100
        }
    }
}

Write-host "`n"



[string]$cmd = Read-Host '~!' 

if($cmd -like "*;*")
{
    $number = 0
    $reverse = $false
    $numSC = 0
    $dic = 0
    $combinationKeywords = $false

    if($cmd -match '-sc(\d+)' -or $cmd -match '--specialcharacters(\d+)')
    {
        $numSC = [int]$Matches[1]

        if($numSC -ne 1 -and $numSC -ne 2)
        {
            Write-Host "Please provide a number between one and two using -sc[1/2]"
            break
        }

    }

    $e = $cmd -split ' '

    if($e -contains '-c' -or $cmd -like "*--combination*")
    {
        $combinationKeywords = $true
    }

    if($e -contains "-rv" -or $cmd -like "*--reverse*")
    {
        $reverse = $true          
    }

    if ($cmd -match "-p([^\s]+)") {
        $path = [string]$Matches[1]
    }

    else {
        "Please provide a path using -p{path}"
        break
    }



    if($cmd -match '-n(\d+)' -or $cmd -match '--number(\d+)')
    {
        $number = [int]$Matches[1]
    }

    if($cmd -match '-d(\d+)' -or $cmd -match '--dictionary(\d+)')
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
    [MANDATORY][-p [string]Path]
    [-sc[int]1 || [int]2] [--specialcharacters[int]1 || [int]2]
    [-rv] [--reverse]
    [-n[int]] [--number[int]]
    [INTERNET CONNECTION REQUIRED][-d[int]] [--dictionary[int]]
    [-c] [--combination]"

    Start-Sleep -Seconds 15

}



