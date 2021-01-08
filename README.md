# sdktest

sdktest is an addon designed to help test the Ashita SDK bindings to Lua. 

_**Please note:** This addon is not intended for general player use. It is not a real addon with any real usage/purpose except for developers. Developers can use this addon as a reference for how to work with the Ashita SDK Lua bindings as well as get some examples of usages._

# Commands

sdktest exposes the following commands:

  * **/sdktest ashitacore** - _Tests the IAshitaCore object._
  * **/sdktest logmanager** - _Tests the ILogManager object._
  * **/sdktest chatmanager** - _Tests the IChatManager object._
  * **/sdktest configurationmanager** - _Tests the IConfigurationManager object._
  * **/sdktest fontobjects** - _Tests the font and primitive objects._
  * **/sdktest guimanager** - _Tests the IGuiManager object._
  * **/sdktest inputmanager** - _Tests the IInputManager and related objects._
  * **/sdktest offsetmanager** - _Tests the IOffsetManager object._
  * **/sdktest packetmanager** - _Tests the IPacketManager object._
  * **/sdktest pluginmanager** - _Tests the IPluginManager object._
  * **/sdktest pointermanager** - _Tests the IPointerManager object._
  * **/sdktest polpluginmanager** - _Tests the IPolPluginManager object._
  * **/sdktest resourcemanager** - _Tests the IResourceManager object._
  * **/sdktest memory autofollow** - _Tests the IAutoFollow memory object._
  * **/sdktest memory castbar** - _Tests the ICastBar memory object._
  * **/sdktest memory entity** - _Tests the IEntity memory object._
  * **/sdktest memory inventory** - _Tests the IInventory memory object._
  * **/sdktest memory party** - _Tests the IParty memory object._
  * **/sdktest memory player** - _Tests the IPlayer memory object._
  * **/sdktest memory recast** - _Tests the IRecast memory object._
  * **/sdktest memory target** - _Tests the ITarget memory object._
  * **/sdktest all** - _Runs all registered tests._

_**Please note:** Some tests may require manual interaction/input by you! Be sure to read the chat output as the tests are running to follow instructions when prompted._

# Environment Recommendations / Configurations

The recommended environment for working with Ashita v4 addons is using Visual Studio Code.

  * VSCode: [https://code.visualstudio.com/](https://code.visualstudio.com/)

VSCode does not natively support Lua files in-full. But, it does offer a lot of user-made extensions to make up for what it doesn't have.

We currently recommend the following extension for working with Lua files inside of VSCode:

  * sumneko.lua: [https://marketplace.visualstudio.com/items?itemName=sumneko.lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)

This extension offers a lot of features in regards to working with addons, and therefore can need some configurations to work with in an ideal manner. This addon includes an example helper-configuration file setup for VSCode to override some of the extensions settings for use with Ashita's Lua setup. `(.vscode/settings.json)`

At this time, the override configuration file helps with:

  * **Lua.diagnostics.disable**: Disables features that will otherwise cause unwanted warnings/errors.
    * **undefined-field**: Disabled because we expand some built-in types/tables of Lua with custom fields/functions that the extension will warn about being unknown.
  * **Lua.diagnostics.globals**:
    * _Types manually exposed by the Addons plugin are added to this list to account for undefined-globals warnings._
