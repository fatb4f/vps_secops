
# OsquerySnapshotEventV1

Derived directly from osquery filesystem logger snapshot events.

## Properties

Name | Type
------------ | -------------
`name` | string
`action` | any
`hostIdentifier` | string
`calendarTime` | string
`unixTime` | number
`epoch` | number
`counter` | number
`numerics` | boolean
`decorations` | [{ [key: string]: OsquerySnapshotEventV1DecorationsValue; }](OsquerySnapshotEventV1DecorationsValue.md)
`snapshot` | Array&lt;{ [key: string]: OsquerySnapshotEventV1DecorationsValue; }&gt;

## Example

```typescript
import type { OsquerySnapshotEventV1 } from '@vps-secops/client'

// TODO: Update the object below with actual values
const example = {
  "name": null,
  "action": null,
  "hostIdentifier": null,
  "calendarTime": null,
  "unixTime": null,
  "epoch": null,
  "counter": null,
  "numerics": null,
  "decorations": null,
  "snapshot": null,
} satisfies OsquerySnapshotEventV1

console.log(example)

// Convert the instance to a JSON string
const exampleJSON: string = JSON.stringify(example)
console.log(exampleJSON)

// Parse the JSON string back to an object
const exampleParsed = JSON.parse(exampleJSON) as OsquerySnapshotEventV1
console.log(exampleParsed)
```

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


