"""Watcher integration adapter contracts.

This module defines a thin adapter boundary for routing normalized events to
watchctl and for handling guardrail action callbacks.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Any, Mapping


@dataclass(frozen=True)
class WatcherEvent:
    """Canonical event envelope forwarded to watcher runtime."""

    topic: str
    severity: str
    source: str
    payload: Mapping[str, Any]


@dataclass(frozen=True)
class WatcherActionResult:
    """Result emitted by watcher after executing a guardrail action."""

    action_id: str
    status: str
    result_message: str


def to_watcher_event(event: Mapping[str, Any]) -> WatcherEvent:
    """Map a normalized telemetry event dict to WatcherEvent."""

    return WatcherEvent(
        topic=str(event.get("topic", "")),
        severity=str(event.get("severity", "info")),
        source=str(event.get("source", "unknown")),
        payload=dict(event),
    )
