#Informatsion collecting and saving strings to variables
$Kasutaja = Get-ADUser test.test
$Samacc = $Kasutaja.SamAccountName
$Grupid = Get-ADPrincipalGroupMembership -Identity $Samacc
$DN = $kasutaja.DistinguishedName
#Locate teh OU and store it to variable
$DestOU = 'OU=sample,OU=users,OU=SANDBOX,DC=hidden,DC=local'
#Controlls does user have goup name called "LHP test" if do removes it
If ($Grupid.name -like "LHP test"){
     Write-Host "User $Samacc  is on LHP group"
     Remove-ADGroupMember -Identity "LHP test" -Member $Kasutaja
}
else {
    Write-Host "Grupp does not exist"
    break
}
#Adding user "Member Of" groups 
$AddGrupid = "parameter 1","paramter 2","parameter 3"...				
$AddGrupid | Add-ADGroupMember -Members $Samacc
#replacing parameters on atribute editor
Set-ADUser -Identity $Kasutaja -Replace @{
description = "test1"
extensionAttribute10 = "test2"
extensionAttribute11 = "test3"
extensionAttribute12 = "test4"
valdkond = "test5"
msExchHideFromAddressLists = $false
}
#Give user a new password
Set-ADAccountPassword -Identity $Samacc -NewPassword (ConvertTo-SecureString -AsPlainText ******* -Force)
#Mooving user to right location
Move-ADObject -Identity $Kasutaja -TargetPath $DestOU
Write-Output "All actions taken on user $Samacc"
