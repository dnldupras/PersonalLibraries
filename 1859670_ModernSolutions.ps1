function KillThatProcess([string] $processName) #Part 1
{

    $processes = Get-Process $processName

    $userProceed = (Read-Host -prompt "There are $($processes.length) instances of the process $processName, currently open, would you like to close them? [Y/N]").ToUpper()

    switch($userProceed)
    {
        Y
        {
            Write-Host "Proceeding"-ForegroundColor Green -BackgroundColor Black
            $processes| kill
            Write-Host "The $($processes.length) instances of $processName have been terminated."
            Start-Sleep 5
        }
        default
        {
            Write-Host "Cancelling"-ForegroundColor Red -BackgroundColor Black
            Start-Sleep 5
        }
    }

}

function Bamboozle([string]$filePath) #Part 2
{
    [char]$randomLetter = (Get-Random -Minimum 65 -Maximum 90) #Selects random ascii val for letters (65 to 90)
    
    Write-Host "The random letter was : $randomLetter, haha aint that quirky and funny hehe XD wow PogChamp HAHA EMOJI :)"

    Set-Location $filePath
    Get-ChildItem *$randomLetter*  | Where { ! $_.PSIsContainer } | remove-item -WhatIf  #Selects all items in current file path that contain the random letter, if it is not a container (folder) what if deletes

    pause
}



###Main###

Write-Host "What function would you like to call?"
Write-Host "1. KillThatProcess"
Write-Host "2. Bamboozle"
$userChoice = (Read-Host)

switch($userChoice)
{
    1
    {
    $processName = (Read-Host -prompt "You've chosen KillThatProcess, it requires a process name to kill, what process would you like to kill?")
    KillThatProcess($processName)
    }
    2
    {
    $pathPrompt = (Read-Host -prompt "You've chosen Bamboozle, would you like to send a file path to it? If not, it will default to the current directory.[Y/N]").ToUpper()

    switch($pathPrompt)
    {

        Y
        {
        $Path = (Read-Host -prompt "What path would you like to send?")
        Bamboozle($Path)
        }
        Default
        {
        Bamboozle($PSScriptRoot)
        }

    }

    }
    default
    {
    Write-Host "You entered an invalid choice, please do better next time and choose the number 1 or 2."
    }
}
