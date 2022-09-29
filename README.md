# DOT iOS SDK Samples

A collection of quickstart samples demonstrating the DOT iOS SDK. [Read more about DOT iOS SDK](https://developers.innovatrics.com/digital-onboarding/technical/ios-development/).

## Setup

1. Check if your CocoaPods is up to date with the command `pod --version`. If not, use the command `[sudo] gem install cocoapods`.
1. Run `pod install --repo-update` command in the project directory.
1. After the pod installation is finished, open DotSdkSamples.xcworkspace in Xcode.
1. In the **General** tab of DotSdkSamples target, choose your unique **Bundle Identifier**. This identifier is used for the generation of the license.
1. Complete app signing configuration using your certificates and profiles.
1. Run the sample and your **LicenseId** will be printed in the terminal.
1. To obtain a license, please contact `support@innovatrics.com` and send them your **Bundle Identifier** and **LicenseId**.
1. After you receive your license, rename the license file to `dot_face_license.lic` and import it to the DotSdkSamples project.
1. The setup is now complete and you can run DOT iOS SDK samples.

## Samples

| Sample                    | Description                                                                                                           |
|:--------------------------|:----------------------------------------------------------------------------------------------------------------------|
| **Document Auto Capture** | Basic component sample.                                                                                               |
| **NFC Reading**           | Combination of Document Auto Capture component with enabled MRZ recognition and NFC Travel Document Reader component. |
| **Face Auto Capture**     | Component with Passive Liveness evaluation.                                                                           |
| **Smile Liveness**        | Basic component sample.                                                                                               |
| **Face Matcher**          | Perform face matching using image resources.                                                                          |

In case when the Face-related samples do not work because of the expired DOT Face license, please contact `support@innovatrics.com` in order to obtain a new license file.

## Changelog

All notable changes are documented in `CHANGELOG.md`.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## Versioning

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
