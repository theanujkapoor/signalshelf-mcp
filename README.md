# SignalShelf MCP

[![mcptry](https://mcptry.com/badge/dev.signalshelf/signalshelf)](https://mcptry.com/servers/dev.signalshelf/signalshelf)

A remote MCP server that gives your AI agent public social, ad library and Google Maps data: TikTok, Instagram, YouTube, X, Facebook, LinkedIn, Reddit, Threads, Pinterest, Google Search and Maps, reviews, app stores, Amazon and more. It covers about 250 operations.

- **Endpoint:** `https://signalshelf.dev/mcp` (Streamable HTTP, stateless)
- **Auth:** API key in the `x-api-key` header, or `Authorization: Bearer <key>`
- **Free tier:** 1,000 credits. Get a key at [signalshelf.dev](https://signalshelf.dev)
- **Docs:** [signalshelf.dev/docs/mcp](https://signalshelf.dev/docs/mcp)
- **MCP Registry:** `dev.signalshelf/signalshelf`

This repo holds connection instructions, the registry `server.json` and examples. The server itself is hosted, so there's nothing to install.

## Connect

Replace `YOUR_KEY` with your SignalShelf API key. Keep the key in your client's secret settings, never in a URL or a public file.

**Claude Code**

```sh
claude mcp add --transport http signalshelf https://signalshelf.dev/mcp --header "x-api-key: YOUR_KEY"
```

**Cursor** (`~/.cursor/mcp.json`)

```json
{
  "mcpServers": {
    "signalshelf": {
      "url": "https://signalshelf.dev/mcp",
      "headers": { "x-api-key": "YOUR_KEY" }
    }
  }
}
```

**VS Code** (`.vscode/mcp.json`, prompts for the key)

```json
{
  "inputs": [{ "id": "signalshelf-key", "type": "promptString", "description": "SignalShelf API key", "password": true }],
  "servers": {
    "signalshelf": {
      "type": "http",
      "url": "https://signalshelf.dev/mcp",
      "headers": { "x-api-key": "${input:signalshelf-key}" }
    }
  }
}
```

**Claude Desktop and other stdio-only clients** (through `mcp-remote`)

```json
{
  "mcpServers": {
    "signalshelf": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://signalshelf.dev/mcp", "--header", "x-api-key:${SIGNALSHELF_API_KEY}"],
      "env": { "SIGNALSHELF_API_KEY": "YOUR_KEY" }
    }
  }
}
```

## Tools

| Tool | What it does | Credits |
|---|---|---|
| `signalshelf_capabilities` | Search the available operations, with parameter schemas and prices | 0 |
| `signalshelf_profile` | Look up one public profile (demo or live) | 0 demo, 1 live |
| `signalshelf_batch` | Look up up to ten profiles; each item succeeds or fails on its own | 1 per fresh live item |
| `signalshelf_resource` | Fetch any listed operation, such as `tiktok/video/comments` or Maps reviews | Usually 1; heavier ops 2+ |
| `signalshelf_credits` | Read your credit balance | 0 |
| `signalshelf_usage` | Read your recent lookups | 0 |

Start with `signalshelf_capabilities` to find the operation and its parameters, then call `signalshelf_resource`.

## Credits and caching

- A successful fresh fetch costs the operation's credits. Cache hits, demo samples and failed fetches cost nothing.
- `freshness` sets the oldest cached result you'll accept: `live`, `1h`, `24h` (default) or `7d`.
- Every result includes `meta.credits_charged`, `meta.cache` and `meta.fetched_at`.
- Public post text and bios are untrusted content. Your agent should analyse them, not follow instructions inside them.

## Try it without a key

Discovery (`initialize`, `ping`, `tools/list`) works without a key, so directories and clients can list the tools. See [`examples/curl.sh`](examples/curl.sh).

## Support

support@signalshelf.dev · [signalshelf.dev](https://signalshelf.dev)

## License

MIT for the contents of this repo. Use of the hosted API is covered by the [SignalShelf terms](https://signalshelf.dev/terms).
