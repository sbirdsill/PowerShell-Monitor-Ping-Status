Last Updated: March 2, 2018

# List of IPs.
$IP = @("192.168.0.1","192.168.1.1","192.168.2.1","192.168.3.1")

# Pings each host in list of IPs.
foreach ($IP in $IP){
  if (Test-Connection -ComputerName $IP -Count 4 -ErrorAction SilentlyContinue){
    Write-Host "$IP is up"
  }
  else{

# If a host is down, send an email alert.
$Password = Get-Content "C:\Scripts\Password.txt" | ConvertTo-SecureString
$EmailTo = "youremail@yourdomain.com"
$EmailFrom = "smtp@yourdomain.com"
$Subject = "Host is down!"
$Body = "$IP is down."
$SMTPServer = "smtp.yourdomain.com"
$SMTPMessage = New-Object System.Net.Mail.MailMessage($EmailFrom,$EmailTo,$Subject,$Body)
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPClient.EnableSsl = $true 
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($EmailFrom, $Password); 
$SMTPClient.Send($SMTPMessage)
  }
}
