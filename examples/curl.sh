#!/bin/sh
# SignalShelf MCP over plain HTTP. tools/list works without a key; tool calls need one.
URL=https://signalshelf.dev/mcp

# List tools (no key needed)
curl -s "$URL" -H 'content-type: application/json' -H 'accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}'
echo

# Find Instagram operations (zero credits; needs SIGNALSHELF_API_KEY)
[ -n "$SIGNALSHELF_API_KEY" ] && curl -s "$URL" -H 'content-type: application/json' -H 'accept: application/json, text/event-stream' \
  -H "x-api-key: $SIGNALSHELF_API_KEY" \
  -d '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"signalshelf_capabilities","arguments":{"query":"instagram","limit":5}}}'
echo
