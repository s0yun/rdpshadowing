# rdpshadowing

A quick script for building the correct syntax structure to shadow a Windows Console Session.

## Usage

To use this script, just download it and run it as an administrator . Please be sure to check that your [Powershell execution policy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.1) allows this. 

1. Enter the  IP of the Machine you'd like to connect to
2. Enter the session ID you'd like to connect to
3. Respond with Y/N to indicate if you'd like to control the session


## Prerequisites
In order for this to work, you'll need to have changed your local security policy or used a GPO to enable the RPC server traffic through the firewall. In order to minimize the attack surface this might provide, use two separate GPOs - one to enable RDP access, and another to enable RDP Shadowing and remote control.

RDP Access - **Required Modifications**

**Computer Configuration** >> **Policies** >> **Windows Settings** >> **Security Settings** >> **Windows Firewall with Advanced Security**
Create a new inbound rule following this flow on the wizard.

- Port
- TCP _'3389'_
- Allow Connection
- Tick all three profiles **or the current network profile you are using**
- Name the rule 'RDP Rule'

**Computer Configuration >> **Administrative Templates** >> ** Windows Components** >> **Remote Desktop Services**  >> **Remote Desktop Session Host**  >> **Connections**

1. Allow users to connect remotely by using Remote Desktop Services
   _Enabled_
2. Allow the connection only from computers running Remote Desktop with Network Level Authentication
   _Enabled_

Shadowing - **Required Modifications**

**Computer Configuration** >> **Policies** >> **Windows Settings** >> **Security Settings** >> **Windows Firewall with Advanced Security**
Create a new inbound rule following this flow on the wizard:
- Predefined
- Remote Desktop
- Tick _Remote Desktop - Shadow (TCP-In)_
- Allow

**Computer Configuration**  >> **Administrative Templates**  >> **Windows Components**>> **Remote Desktop Services**  >> **Remote Desktop Session Host**  >> **Connections**

1. Set rules for remote control of Remote Desktop Services user sessions
   _Full Control without user's permission_

**Computer Configuration** >> **Preferences** >> **Windows Settings** >> **Registry**
   _New Registry item_
- [ ] Action - Update
- [ ] Hive - HKEY_LOCAL_MACHINE
- [ ] Key Path SYSTEM\CurrentControlSet\Control\Terminal Server
- [ ] Value Name - AllowRemoteRPC
- [ ] Value Type - REG_DWORD
- [ ] Value data - 1

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
GNU General Public License v3.0
