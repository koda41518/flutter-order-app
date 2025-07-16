final repo = RestaurantRepository();

@override
void initState() {
  super.initState();
  repo; // déclenche l'init auto
}

@override
Widget build(BuildContext context) {
  return ChangeNotifierProvider.value(
    value: repo,
    child: Consumer<RestaurantRepository>(
      builder: (context, repo, _) {
        final restos = repo.restos;
        if (restos.isEmpty) return const Center(child: CircularProgressIndicator());
        return ListView(...);
      },
    ),
  );
}