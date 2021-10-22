#Cellects all the names form file and add in to distribution list.
Get-Content -Path "C:\Users\sample\Desktop\names.txt" | %{
$user = Get-ADUser -filter {name -eq $_}
Add-MailboxPermission -Identity "sample" -member $user.UserPrincipalName
Write-Output $user.UserPrincipalName
}
