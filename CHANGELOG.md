# Change Log
## Unreleased
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v2.0.1...master)

## [v2.0.1](https://github.com/sue445/index_shotgun/releases/tag/v2.0.1) (2025/01/18)
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v2.0.0...v2.0.1)

* Fix `NameError: uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger` when activesupport < 7.1
  * https://github.com/sue445/index_shotgun/pull/151

## [v2.0.0](https://github.com/sue445/index_shotgun/releases/tag/v2.0.0) (2024/05/15)
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v1.0.3...v2.0.0)

* :bomb: **[BREAKING CHANGE]** Requires Ruby2.5+ and activerecord 6.0+
  * https://github.com/sue445/index_shotgun/pull/141
* Upgrade to rubocop 1.28.2
  * https://github.com/sue445/index_shotgun/pull/142

## [v1.0.3](https://github.com/sue445/index_shotgun/releases/tag/v1.0.3) (2024/05/14)
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v1.0.2...v1.0.3)

* Fixed false positives when there are multiple unique indexes on a single table
  * https://github.com/sue445/index_shotgun/pull/140

## [v1.0.2](https://github.com/sue445/index_shotgun/releases/tag/v1.0.2) (2023/12/28)
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v1.0.1...v1.0.2)

* Fixed deprecation warning in activesupport 7.1
  * https://github.com/sue445/index_shotgun/pull/134

## [v1.0.1](https://github.com/sue445/index_shotgun/releases/tag/v1.0.1) (2021/11/20)
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v1.0.0...v1.0.1)

* Enable MFA requirement for gem releasing
  * https://github.com/sue445/index_shotgun/pull/111

## [v1.0.0](https://github.com/sue445/index_shotgun/releases/tag/v1.0.0) (2019/01/06)
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v0.3.0...v1.0.0)

### Breaking changes :bomb:
* Drop support for Ruby 2.2 and Rails 4.2
  * https://github.com/sue445/index_shotgun/pull/60

## [v0.3.0](https://github.com/sue445/index_shotgun/releases/tag/v0.3.0) (2016/07/23)
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v0.2.1...v0.3.0)

**Merged pull requests:**

- exit on failure if exists duplicate index [\#26](https://github.com/sue445/index_shotgun/pull/26) ([sue445](https://github.com/sue445))
- Resupport ruby 2.1 [\#25](https://github.com/sue445/index_shotgun/pull/25) ([sue445](https://github.com/sue445))
- Support activerecord 5 [\#24](https://github.com/sue445/index_shotgun/pull/24) ([sue445](https://github.com/sue445))
- Add CI for oracle [\#23](https://github.com/sue445/index_shotgun/pull/23) ([sue445](https://github.com/sue445))
- Test ruby 2.3.1 [\#22](https://github.com/sue445/index_shotgun/pull/22) ([sue445](https://github.com/sue445))

## [v0.2.1](https://github.com/sue445/index_shotgun/releases/tag/v0.2.1) (2016/02/17)
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v0.2.0...v0.2.1)

**Closed issues:**

- Support mysql2 0.4.x [\#8](https://github.com/sue445/index_shotgun/issues/8)

**Merged pull requests:**

- Support mysql2 0.4+ [\#20](https://github.com/sue445/index_shotgun/pull/20) ([sue445](https://github.com/sue445))
- Relax bundler version [\#19](https://github.com/sue445/index_shotgun/pull/19) ([sue445](https://github.com/sue445))
- Add ruby 2.3 [\#18](https://github.com/sue445/index_shotgun/pull/18) ([sue445](https://github.com/sue445))

## [v0.2.0](https://github.com/sue445/index_shotgun/releases/tag/v0.2.0) (2015/11/09)
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v0.1.0...v0.2.0)

**Merged pull requests:**

- Support Oracle Database [\#17](https://github.com/sue445/index_shotgun/pull/17) ([koic](https://github.com/koic))
- Add group to database gem dependency [\#16](https://github.com/sue445/index_shotgun/pull/16) ([sue445](https://github.com/sue445))

## [v0.1.0](https://github.com/sue445/index_shotgun/releases/tag/v0.1.0) (2015/09/30)
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v0.1.0.beta3...v0.1.0)

**Closed issues:**

- Write doc [\#9](https://github.com/sue445/index_shotgun/issues/9)
- 1st release features [\#4](https://github.com/sue445/index_shotgun/issues/4)

**Merged pull requests:**

- Add ask\_password [\#14](https://github.com/sue445/index_shotgun/pull/14) ([sue445](https://github.com/sue445))
- Add option alias [\#13](https://github.com/sue445/index_shotgun/pull/13) ([sue445](https://github.com/sue445))
- Tweak result message of unique index [\#12](https://github.com/sue445/index_shotgun/pull/12) ([sue445](https://github.com/sue445))
- Write doc [\#10](https://github.com/sue445/index_shotgun/pull/10) ([sue445](https://github.com/sue445))

## [v0.1.0.beta3](https://github.com/sue445/index_shotgun/releases/tag/v0.1.0.beta3) (2015/09/17)
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v0.1.0.beta2...v0.1.0.beta3)

**Merged pull requests:**

- Add summary [\#11](https://github.com/sue445/index_shotgun/pull/11) ([sue445](https://github.com/sue445))

## [v0.1.0.beta2](https://github.com/sue445/index_shotgun/releases/tag/v0.1.0.beta2) (2015/09/16)
[Full Changelog](https://github.com/sue445/index_shotgun/compare/v0.1.0.beta1...v0.1.0.beta2)

**Merged pull requests:**

- Impl client [\#7](https://github.com/sue445/index_shotgun/pull/7) ([sue445](https://github.com/sue445))
- Impl index\_shotgun:fire [\#6](https://github.com/sue445/index_shotgun/pull/6) ([sue445](https://github.com/sue445))
- Impl perform [\#5](https://github.com/sue445/index_shotgun/pull/5) ([sue445](https://github.com/sue445))
- Feature/rubocop [\#3](https://github.com/sue445/index_shotgun/pull/3) ([sue445](https://github.com/sue445))
- Setup codeclimate, coveralls [\#2](https://github.com/sue445/index_shotgun/pull/2) ([sue445](https://github.com/sue445))
- Setup travis [\#1](https://github.com/sue445/index_shotgun/pull/1) ([sue445](https://github.com/sue445))

## [v0.1.0.beta1](https://github.com/sue445/index_shotgun/releases/tag/v0.1.0.beta1) (2015/09/06)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
