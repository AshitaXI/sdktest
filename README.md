# sdktest

sdktest is an addon designed to help test the Ashita SDK bindings to Lua. 

This is not intended for actual use outside of development testing and demonstrations of API usage within addons.

# Addon Development Environment

sdktest is developed with the following environment configurations:

  * Visual Studio Code (Insiders build; latest version.) _(Insiders branch is not required.)_
  * Lua language support extension.
    * **Link**: https://marketplace.visualstudio.com/items?itemName=sumneko.lua

To use the Lua extensions to their fullest for addon development; the following should be used to configure them:

  - Create a local environment settings override for the given addon within the addons parent folder.
    - Open the addon folder you are developing for. (ie. addons/sdktest/)
    - Create a new folder named `.vscode` if one does not already exist.
    - Create a new settings file named `settings.json` if one does not already exist.

Within the `settings.json` file, we will configure both extensions via the following:

```json
{
    "Lua.diagnostics.globals": [
        "addon",
        "ashita"
    ]
}
```

- Extension: `sumneko.lua`
  - We are defining known globals that the editor is unaware of due to how addons are loaded.
