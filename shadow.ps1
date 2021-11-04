#Requires -RunAsAdministrator
# Get the FQDN or IP of the Windows Instance
$pc = Read-Host 'What is the FQDN or IP of the Windows Instance you want to connect to?'
# Find and display the active sessions on that PC
query session /server:$pc
$sessionid = Read-Host 'From the above sessions which do you want to connect to?'

# Find out if this will be a session with input or just shadowing
do {
$control = read-Host 'Do you wish to have control during this session? Y/N?'
} until (($control -eq 'y') -or ($control-eq 'n'))

# Run the command with the specified PC and session ID
if ($control -eq 'y')
{
mstsc /shadow:$sessionid /v:$pc /control /noConsentPrompt
}else {
mstsc /shadow:$sessionid /v:$pc /noConsentPrompt
}

