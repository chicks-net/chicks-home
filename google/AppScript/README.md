# Google Apps Script Collection

A collection of Google Apps Script utilities for automating Google Workspace tasks.

## Scripts

### update_day_script.gs

Automatically updates day-of-the-week references in Google Docs to tomorrow's
day. Perfect for maintaining daily templates or recurring documents.

**Features:**

- Finds and updates both full day names (Monday, Tuesday) and abbreviations
  (Mon, Tue)
- Adds a custom menu to Google Docs for easy access
- Shows toast notifications on completion
- Works with any Google Doc containing day references in the first line

**Setup:**

1. Open your Google Doc
2. Go to Extensions → Apps Script
3. Replace default code with the script content
4. Save and authorize permissions
5. Refresh your document to see the "Day Updater" menu

## Useful Links

### Official Documentation

- [Google Apps Script Overview](https://developers.google.com/apps-script)
- [Google Docs Service Reference](https://developers.google.com/apps-script/reference/document)
- [Spreadsheet Service Reference](https://developers.google.com/apps-script/reference/spreadsheet)

### Getting Started

- [Apps Script Quickstart](https://developers.google.com/apps-script/quickstart)
- [Script Editor Guide](https://developers.google.com/apps-script/guides/script-editor)
- [Triggers and Events](https://developers.google.com/apps-script/guides/triggers)

### Advanced Topics

- [HTML Service](https://developers.google.com/apps-script/guides/html) -
  For web apps and dialogs
- [Lock Service](https://developers.google.com/apps-script/reference/lock) -
  Preventing concurrent executions
- [Properties](https://developers.google.com/apps-script/reference/properties) -
  Storing script data

### Community Resources

- [Apps Script Community](https://developers.google.com/apps-script/support)
- [Stack Overflow - google-apps-script tag](https://stackoverflow.com/questions/tagged/google-apps-script)

## Development Tips

- Use `console.log()` for debugging - view logs in the Apps Script editor
- Test scripts with sample data before running on important documents
- Set up triggers carefully to avoid infinite loops
- Always handle errors gracefully with try/catch blocks
