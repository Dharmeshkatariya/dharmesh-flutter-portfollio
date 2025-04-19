import 'dart:html' as html;
void updateQueryParams(String key, String value) {
  final uri = Uri.parse(html.window.location.href);

  // If the URL contains a hash (#), preserve it.
  final baseUrl = uri.toString().split('#')[0];
  final hashFragment = uri.fragment; // This is everything after the '#'.

  // Parse query parameters from the fragment if any.
  final fragmentUri = Uri.parse(hashFragment);
  final queryParams = Map<String, String>.from(fragmentUri.queryParameters);

  // Update or add the query parameter.
  queryParams[key] = value;

  // Reconstruct the fragment with the updated query parameters.
  final newFragment = fragmentUri.replace(queryParameters: queryParams).toString();

  // Construct the new URL.
  final newUrl = baseUrl + '#' + newFragment;

  // Update the browser's address bar without refreshing the page.
  html.window.history.pushState(null, '', newUrl);
}

Map<String, String> getQueryParams() {
  final fragment = Uri.base.fragment; // Get the part after the `#`.

  if (fragment.isEmpty || !fragment.contains('?')) {
    return {};
  }

  // Split the fragment to isolate the query string and parse it.
  final queryPart = fragment.split('?').last;
  return Uri.parse('?$queryPart').queryParameters;
}

void clearQueryParams() {
  final uri = Uri.base;

  // Rebuild the URI without query parameters
  final newUri = Uri(
    scheme: uri.scheme,
    host: uri.host,
    path: uri.path,
    port: uri.port,
    fragment: uri.fragment, // Preserve the fragment if needed
  );

  // Update the browser's history
  html.window.history.pushState(null, '', newUri.toString());
}

void removeQueryParam(String key) {
  final uri = Uri.parse(html.window.location.href);

  final baseUrl = uri.toString().split('#')[0];
  final hashFragment = uri.fragment; // This is everything after the '#'.

  final fragmentUri = Uri.parse(hashFragment);
  final queryParams = Map<String, String>.from(fragmentUri.queryParameters);
  queryParams.remove(key);
  final newFragment = fragmentUri.replace(queryParameters: queryParams).toString();
  final newUrl = baseUrl + '#' + newFragment;
  html.window.history.pushState(null, '', newUrl);
}