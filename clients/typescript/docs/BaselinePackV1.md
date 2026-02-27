
# BaselinePackV1

5-minute baseline pack generated from osquery snapshot logs.

## Properties

Name | Type
------------ | -------------
`schemaVersion` | any
`collector` | any
`host` | string
`generatedAtUtc` | Date
`windowSeconds` | number
`windowStartUnix` | number
`windowEndUnix` | number
`events` | [Array&lt;OsquerySnapshotEventV1&gt;](OsquerySnapshotEventV1.md)
`manifestSha256` | string

## Example

```typescript
import type { BaselinePackV1 } from '@vps-secops/client'

// TODO: Update the object below with actual values
const example = {
  "schemaVersion": null,
  "collector": null,
  "host": null,
  "generatedAtUtc": null,
  "windowSeconds": null,
  "windowStartUnix": null,
  "windowEndUnix": null,
  "events": null,
  "manifestSha256": null,
} satisfies BaselinePackV1

console.log(example)

// Convert the instance to a JSON string
const exampleJSON: string = JSON.stringify(example)
console.log(exampleJSON)

// Parse the JSON string back to an object
const exampleParsed = JSON.parse(exampleJSON) as BaselinePackV1
console.log(exampleParsed)
```

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


