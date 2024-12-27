### Patches for VSCode

Within the [`configuration`](../vscode/settings.json), there are some patches included:

```json
{
  "apc.imports": [
    "~/.custom-loaders/patch-vscode.js",
    "~/.custom-loaders/patch-vscode.css"
  ]
}
```

Download them from [`src`](./src/), put them wherever you like and change `apc.imports` paths accordingly to the place you've chosen for those files.

> [!TIP]
> If you have Windows, consider using `/C:/...` path convention (change `C` to your disk name), otherwise it may not be loaded.