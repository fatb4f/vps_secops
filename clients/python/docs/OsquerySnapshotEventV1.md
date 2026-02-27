# OsquerySnapshotEventV1

Derived directly from osquery filesystem logger snapshot events.

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **str** |  | 
**action** | **object** |  | 
**host_identifier** | **str** |  | 
**calendar_time** | **str** |  | 
**unix_time** | **int** |  | 
**epoch** | **int** |  | [optional] 
**counter** | **int** |  | [optional] 
**numerics** | **bool** |  | [optional] 
**decorations** | [**Dict[str, OsquerySnapshotEventV1DecorationsValue]**](OsquerySnapshotEventV1DecorationsValue.md) |  | [optional] 
**snapshot** | **List[Dict[str, OsquerySnapshotEventV1DecorationsValue]]** |  | 

## Example

```python
from vps_secops_client.models.osquery_snapshot_event_v1 import OsquerySnapshotEventV1

# TODO update the JSON string below
json = "{}"
# create an instance of OsquerySnapshotEventV1 from a JSON string
osquery_snapshot_event_v1_instance = OsquerySnapshotEventV1.from_json(json)
# print the JSON string representation of the object
print(OsquerySnapshotEventV1.to_json())

# convert the object into a dict
osquery_snapshot_event_v1_dict = osquery_snapshot_event_v1_instance.to_dict()
# create an instance of OsquerySnapshotEventV1 from a dict
osquery_snapshot_event_v1_from_dict = OsquerySnapshotEventV1.from_dict(osquery_snapshot_event_v1_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


