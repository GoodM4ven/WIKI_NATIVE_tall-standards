# AlpineJS (v3)

[AlpineJS](https://alpinejs.dev) is a lightweight reactive layer for HTML-first applications.

# Tips

## Precautions

- In `setTimeout` / [`setInterval`](https://developer.mozilla.org/en-US/docs/Web/API/setInterval) callbacks, `this` may no longer refer to the Alpine component. Pass values explicitly or use [`bind()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind).
- Use [`x-init`](https://alpinejs.dev/directives/init) for setup logic tied to markup. For reusable components, use an `init()` method inside [`Alpine.data()`](https://alpinejs.dev/globals/alpine-data).
- For inline [`x-data`](https://alpinejs.dev/directives/data), avoid conflicting quote styles. Use single quotes or template literals for inner strings when needed.

## Best Practices

- Avoid duplicating initialization in both outer `x-init` and component `init()` unless you explicitly need both execution points.
- Keep small UI logic inline, then extract to `Alpine.data()` once behavior grows.

## Coding Style

- Keep `x-data` focused on state and actions, and keep side-effect-heavy bootstrapping in `x-init`/`init()`.
