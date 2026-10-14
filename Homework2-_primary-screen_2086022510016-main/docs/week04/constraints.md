# Constraint Diagnosis & Analysis


1. a. Before :

```dart
Row(
  children: [
    Icon(Icons.newspaper),
    const SizedBox(width: 8),
    Text(
      'News & Order Updates Khas Hasil Karya Seni Nusantara Makassar Indonesia Paling Lengkap',
    ),
  ],
)

b. After :

Expanded(
  child: Text(
    'News & Order Updates Khas Hasil Karya Seni Nusantara Makassar Indonesia Paling Lengkap',
  ),
)

OR

Expanded(
  child: Text(
    'News & Order Updates',
  ),
)

Constraint Rule Violated: passes unbounded width constraints to its unconstrained children which results in a long Text widget overflowing to the right beyond the right edge of the screen

2. a. Before :

Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    TextButton(onPressed: onCancel, child: const Text('Batalkan')),
    IconButton.outlined(...),
    FilledButton(onPressed: onBuy, child: const Text('Beli')),
  ],
)

b. After :

Wrap(
  alignment: WrapAlignment.end,
  crossAxisAlignment: WrapCrossAlignment.center,
  spacing: 8,
  runSpacing: 4,
  children: [
    TextButton(...),
    IconButton.outlined(...),
    FilledButton(...),
  ],
)

Constraint Rule Violated: The Row forces all of its children to take a single row (no line wrapping) causing the combined width of the buttons to overflow the tight width constraint placed on the right edge of the card is too tight.

3. a Before :

ListView.builder(
  itemCount: filteredProducts.length,
  itemBuilder: (context, index) => ProductCardWidget(...),
)

b. After : 

ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: filteredProducts.length,
  itemBuilder: (context, index) => ProductCardWidget(...),
)

Constraint Rule Violated: Column imposes an unbounded vertical constraint (i.e., infinite height) on its child that wants to claim infinite height causes layout renders error (blank screen).