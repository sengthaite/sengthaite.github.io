class CategoryTabItemModel {
  final String title;
  final String date;
  final String description;
  final void Function()? onTap;

  CategoryTabItemModel({
    required this.title,
    required this.date,
    required this.description,
    this.onTap,
  });
}
