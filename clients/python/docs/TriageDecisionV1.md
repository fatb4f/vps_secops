# TriageDecisionV1


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**schema_version** | **object** |  | 
**decision** | **str** |  | 
**confidence** | **float** |  | 
**rule_id** | **str** |  | 
**policy_version** | **str** |  | 
**iocs** | [**List[TriageDecisionV1IocsInner]**](TriageDecisionV1IocsInner.md) |  | [optional] 
**evidence_refs** | **List[str]** |  | 
**recommended_next_action** | **str** |  | 
**notes** | **str** |  | [optional] 

## Example

```python
from vps_secops_client.models.triage_decision_v1 import TriageDecisionV1

# TODO update the JSON string below
json = "{}"
# create an instance of TriageDecisionV1 from a JSON string
triage_decision_v1_instance = TriageDecisionV1.from_json(json)
# print the JSON string representation of the object
print(TriageDecisionV1.to_json())

# convert the object into a dict
triage_decision_v1_dict = triage_decision_v1_instance.to_dict()
# create an instance of TriageDecisionV1 from a dict
triage_decision_v1_from_dict = TriageDecisionV1.from_dict(triage_decision_v1_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


