# supply_aptoide plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-supply_aptoide)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-supply_aptoide`, add it to your project by running:

```bash
fastlane add_plugin supply_aptoide
```

## About supply_aptoide

Upload metadata, screenshots and binaries to Aptoide.


## Setup & Usage

1) Create a JSON file containing your aptoide username and password somewhere on the filesystem.

```
{
  "username": "...",
  "password": "..."
}
```

2) Add supply_aptoide action to Fastfile after gradle build action.

```
supply_aptoide(
  json_credential_path: './aptoide-credentials.json', # path to JSON file from above
  repo: "#{your_aptoide_repo_here}", # aptoide private repo
  only_user_repo: true,
  apk: "#{lane_context[SharedValues::GRADLE_APK_OUTPUT_PATH]}"
)
```

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
