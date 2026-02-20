# FilamentPHP (v5)

[FilamentPHP](https://filamentphp.com) is a strong admin-panel layer for [TALL](https://tallstack.dev), with reusable packages for [forms](https://filamentphp.com/docs/forms), [tables](https://filamentphp.com/docs/tables), [actions](https://filamentphp.com/docs/actions), and [notifications](https://filamentphp.com/docs/notifications).

# Tips

## Prerequisite Knowledge

- In reactive form callbacks, values accessed through `$state`, `$get`, or `$set` are UI-state helpers. Keep server-side validation rules authoritative and run normal validation before persistence.

## Best Practices

- On submit, read values from `getState()` once, map them clearly, and persist.
- Reset or refill form state deliberately after a successful action to prevent stale UI values.
