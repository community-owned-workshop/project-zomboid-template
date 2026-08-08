# Upload to the Steam Workshop

## 1. Prepare the Workshop folder

Run:

```powershell
.\tools\prepare-for-workshop.ps1
```

The script generates the current metadata and copies the mod to:

```text
%USERPROFILE%\Zomboid\Workshop\[MyMod]
```

## 2. Upload from Project Zomboid

1. Start Project Zomboid.
2. Open **Workshop**.
3. Open **Create and update items**.
4. Select the staged mod.
5. Review title, description, preview image, visibility and tags.
6. Upload the item.

For the first upload, Steam creates the Workshop item and assigns its Workshop ID.

## 3. Store the Workshop ID

After the first upload, copy the new Steam Workshop ID into `metadata.json`:

```json
"workshop": {
  "id": "1234567890"
}
```

Run `prepare-for-workshop.ps1` again before later uploads so the generated `workshop.txt` contains the correct ID.

## Updating an existing Workshop item

For later releases:

```powershell
.\tools\prepare-for-workshop.ps1
```

Then open **Workshop -> Create and update items** in Project Zomboid, select the existing item and upload the update.
