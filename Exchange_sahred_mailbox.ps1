#If you dont have connection between POWERSHELL and Exchange server then first run command commented out:
#Connect-ExchangeOnline -UserPrincipalName <parameter>
#Collecting user(s) informatiosn.
Get-Content -Path "C:\Users\sample\Desktop\names.txt" | %{
$user = Get-ADUser -filter {name -eq $_}
#Manage user(s) roles:
#Full access "Read and manage" role. If not needed comment it out
Add-MailboxPermission -Identity "sample@sample.com" -AccessRights FullAccess -InheritanceType All -AutoMapping:$true -user $user.UserPrincipalName
#Send as access. Coment out if not needed
Add-RecipientPermission -Identity "sample@sample.com" -AccessRights SendAs -Confirm:$false -Trustee $user.UserPrincipalName
Write-Output $user.UserPrincipalName
}
