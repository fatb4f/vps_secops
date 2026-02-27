
# TriageDecisionV1


## Properties

Name | Type
------------ | -------------
`schemaVersion` | any
`decision` | string
`confidence` | number
`ruleId` | string
`policyVersion` | string
`iocs` | [Array&lt;TriageDecisionV1IocsInner&gt;](TriageDecisionV1IocsInner.md)
`evidenceRefs` | Array&lt;string&gt;
`recommendedNextAction` | string
`notes` | string

## Example

```typescript
import type { TriageDecisionV1 } from '@vps-secops/client'

// TODO: Update the object below with actual values
const example = {
  "schemaVersion": null,
  "decision": null,
  "confidence": null,
  "ruleId": null,
  "policyVersion": null,
  "iocs": null,
  "evidenceRefs": null,
  "recommendedNextAction": null,
  "notes": null,
} satisfies TriageDecisionV1

console.log(example)

// Convert the instance to a JSON string
const exampleJSON: string = JSON.stringify(example)
console.log(exampleJSON)

// Parse the JSON string back to an object
const exampleParsed = JSON.parse(exampleJSON) as TriageDecisionV1
console.log(exampleParsed)
```

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


