/**
 * Google Apps Script to update the day of the week in the top line of a document
 * This script finds the first line, looks for a day of the week, and updates it to tomorrow
 * 
 * Key Features:
 * - Finds the first paragraph in the document
 * - Searches for both full day names (Monday, Tuesday, etc.) and short forms (Mon, Tue, etc.)
 * - Calculates tomorrow's day and replaces the found day
 * - Shows a toast notification when complete
 * - Adds a custom menu "Day Updater" to Google Docs for easy access
 * 
 * How to use it:
 * 1. Open your Google Doc
 * 2. Go to Extensions → Apps Script
 * 3. Replace the default code with this script
 * 4. Save and authorize the script
 * 5. Refresh your document - you'll see a new "Day Updater" menu
 * 6. Click "Update Day to Tomorrow" to run it
 * 
 * Advanced usage:
 * - You can set up a time-based trigger to run dailyDayUpdate() automatically each day
 * - The script logs its actions so you can debug in the Apps Script editor
 * - It handles both full and abbreviated day names with word boundary matching
 */

function updateDayToTomorrow() {
  // Get the active document
  const doc = DocumentApp.getActiveDocument();
  const body = doc.getBody();
  
  // Get the first paragraph
  const firstParagraph = body.getParagraphs()[0];
  if (!firstParagraph) {
    Logger.log('No paragraphs found in document');
    return;
  }
  
  // Get current text of the first line
  const currentText = firstParagraph.getText();
  Logger.log('Current first line: ' + currentText);
  
  // Days of the week arrays
  const daysOfWeek = [
    'Sunday', 'Monday', 'Tuesday', 'Wednesday', 
    'Thursday', 'Friday', 'Saturday'
  ];
  
  const daysOfWeekShort = [
    'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
  ];
  
  // Calculate tomorrow's day
  const today = new Date();
  const tomorrow = new Date(today);
  tomorrow.setDate(today.getDate() + 1);
  const tomorrowDayIndex = tomorrow.getDay();
  const tomorrowDayFull = daysOfWeek[tomorrowDayIndex];
  const tomorrowDayShort = daysOfWeekShort[tomorrowDayIndex];
  
  let updatedText = currentText;
  let dayFound = false;
  
  // Try to replace full day names first
  for (let i = 0; i < daysOfWeek.length; i++) {
    if (currentText.includes(daysOfWeek[i])) {
      updatedText = currentText.replace(daysOfWeek[i], tomorrowDayFull);
      dayFound = true;
      Logger.log('Replaced ' + daysOfWeek[i] + ' with ' + tomorrowDayFull);
      break;
    }
  }
  
  // If no full day name found, try short day names
  if (!dayFound) {
    for (let i = 0; i < daysOfWeekShort.length; i++) {
      // Use word boundaries to avoid partial matches
      const regex = new RegExp('\\b' + daysOfWeekShort[i] + '\\b', 'i');
      if (regex.test(currentText)) {
        updatedText = currentText.replace(regex, tomorrowDayShort);
        dayFound = true;
        Logger.log('Replaced ' + daysOfWeekShort[i] + ' with ' + tomorrowDayShort);
        break;
      }
    }
  }
  
  // Update the document if a day was found and replaced
  if (dayFound && updatedText !== currentText) {
    firstParagraph.setText(updatedText);
    Logger.log('Document updated. New first line: ' + updatedText);
    
    // Show an alert notification
    DocumentApp.getUi().alert(
      'Document Updated',
      'Day updated to ' + tomorrowDayFull,
      DocumentApp.getUi().ButtonSet.OK
    );
  } else if (!dayFound) {
    Logger.log('No day of the week found in the first line');
    DocumentApp.getUi().alert(
      'No Update Made',
      'No day of the week found in first line',
      DocumentApp.getUi().ButtonSet.OK
    );
  } else {
    Logger.log('No change needed - already tomorrow?');
    DocumentApp.getUi().alert(
      'No Update Needed',
      'Day already appears to be correct',
      DocumentApp.getUi().ButtonSet.OK
    );
  }
}

/**
 * Creates a menu item in Google Docs to run the script
 * This function runs automatically when the document is opened
 */
function onOpen() {
  DocumentApp.getUi()
    .createMenu('Regime Edicts')
    .addItem('Update Day to Tomorrow', 'updateDayToTomorrow')
    .addToUi();
}

/**
 * Alternative function that can be triggered daily to automatically update
 * Useful if you want to set up a time-based trigger
 */
function dailyDayUpdate() {
  // You can modify this to target a specific document by ID
  // const doc = DocumentApp.openById('your-document-id-here');
  updateDayToTomorrow();
}
