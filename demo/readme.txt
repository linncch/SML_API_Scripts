Using the CLI or a scripting language of your choice you will:

- Upload localizable.strings to the Smartling platform using Smartling’s file API;
- Upload context.png to the Smartling platform using Smartling’s image context API; and
- Download completed translations using Smartling’s file API.

Documentation is available at:

http://help.smartling.com

Please use API v2. Credentials are provided in credentials.json. Your commands or script should read credentials directly from the file, as opposed to hard-coding them.

After uploading the strings file and image file, log in to the Smartling UI at:

http://dashboard.smartling.com

From here you can authorize the strings for translation (French or German or both), enter translations (any text is fine; it doesn’t matter if you don’t speak the language), and publish the translations.

After publishing the translations, download the completed translations using the CLI or by invoking your script.