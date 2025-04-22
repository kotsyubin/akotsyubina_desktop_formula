// options taken from https://github.com/auberginehill/firefox-customization-files/blob/master/firefox.cfg
pref(toolkit.legacyUserProfileCustomizations.stylesheets, true)
//      Disable telemetry and health reporting
//      https://www.mozilla.org/en-US/privacy/firefox/#health-report
//      https://www.mozilla.org/en-US/privacy/firefox/#telemetry
//      https://gecko.readthedocs.io/en/latest/toolkit/components/telemetry/telemetry/internals/preferences.html
("breakpad.reportURL", "");
pref("browser.tabs.crashReporting.sendReport", false);
pref("datareporting.healthreport.documentServerURI", "");
pref("datareporting.healthreport.service.enabled", false);
pref("datareporting.healthreport.uploadEnabled", false);
pref("datareporting.policy.dataSubmissionEnabled", false);
pref("datareporting.policy.dataSubmissionEnabled.v2", false); //      Firefox 43+ ?
pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);
pref("dom.ipc.plugins.reportCrashURL", false);
pref("toolkit.telemetry.archive.enabled", false);
pref("toolkit.telemetry.cachedClientID", "");
pref("toolkit.telemetry.enabled", false);
pref("toolkit.telemetry.prompted", 2);
pref("toolkit.telemetry.rejected", true);
pref("toolkit.telemetry.server", "");
pref("toolkit.telemetry.unified", false);
pref("toolkit.telemetry.unifiedIsOptIn", true);
pref("toolkit.telemetry.optoutSample", false);
//      Turn on tracking protection
// This makes Firefox block known tracking domains by default.
pref("privacy.trackingprotection.enabled", true);