# Livewire (v4)

[Livewire](https://livewire.laravel.com) provides server-driven UI updates while keeping Blade-centric workflows.


# Tips

## Prerequisite Knowledge

- Livewire component actions run on the server, so API calls are possible from PHP (for example via Laravel's `Http` client).
- If the same backend already has direct service-layer access, prefer calling services instead of routing through your own HTTP API.
- Use Alpine/JavaScript only when browser APIs or client-side behavior are required.
- Treat public properties and methods as externally callable entry points. Always validate and authorize incoming data.


## Precautions

- In `setTimeout` / [`setInterval`](https://developer.mozilla.org/en-US/docs/Web/API/setInterval) callbacks, `this` context can change. Use closures, explicit parameters, or [`bind()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind) when calling `$wire`.
- Calls from JavaScript to Livewire methods return promises. Use `await` in async flows before consuming returned values.


# Learning Resources

## Courses

- [Livewire Screencasts](https://livewire.laravel.com/screencasts/)
