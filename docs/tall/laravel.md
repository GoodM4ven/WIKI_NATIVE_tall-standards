# Laravel (v12)


# Tips

## Helpers

- For nested array access and assignment, use `Arr::get()` and `Arr::set()`.
- When you need to flatten or rebuild nested arrays, use [`Arr::dot()` and `Arr::undot()`](https://laravel.com/docs/helpers#method-array-dot).


## Best Practices

- Prefer validated input (`$request->validated()`) in form requests. Otherwise, use `$request->input('key')` for explicit access.
- Facades are a convenience layer and are testable, but they are not an automatic performance optimization over service classes.
- Keep schema migrations deterministic. Avoid coupling schema changes to runtime model state.


## Intellisense

- When adding `@method` annotations for [facades](https://laravel.com/docs/facades), include inherited methods you rely on. This improves IDE completion and static analysis.


## Package Development

- Trigger [Packagist](https://packagist.org/) updates on tagged releases.
- If you use a manual webhook update flow, use the API [endpoint documented by Packagist](https://packagist.org/about#how-to-update-packages) and the token from your [Packagist profile](https://packagist.org/profile/).


# Our Standards

- Keep model `$fillable` fields in the same order they appear in the UI.
- Define `casts` after `$fillable` for consistency.
- Custom [pivot models](https://laravel.com/docs/eloquent-relationships#defining-custom-intermediate-table-models) can define mass-assignment rules; use `$fillable` or `$guarded` intentionally.
- Use `casts()` when cast definitions need dynamic logic; use a property for static, simple mappings.


# Learning Resources

- [Laracasts](https://laracasts.com)


## Courses

- [Video Streaming with Laravel](https://courses.martinbean.dev/video-streaming-with-laravel) by [Martin Bean](https://twitter.com/martinbean)
