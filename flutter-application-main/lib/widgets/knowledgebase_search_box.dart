import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/knowledgebase_filter_cubit.dart';

class KnowledgebaseSearchBox extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: KnowledgebaseSerchBoxInput(),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }
}

class KnowledgebaseSerchBoxInput extends StatefulWidget {
  const KnowledgebaseSerchBoxInput({Key? key}) : super(key: key);

  @override
  State<KnowledgebaseSerchBoxInput> createState() =>
      _KnowledgebaseSerchBoxInputState();
}

class _KnowledgebaseSerchBoxInputState
    extends State<KnowledgebaseSerchBoxInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
            onPressed: () {
              _controller.clear();
              context.read<KnowledgebaseFilterCubit>().filter(null);
            },
            icon: const Icon(Icons.clear_rounded)),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      onChanged: _onChanged,
    );
  }

  void _onChanged(String value) {
    context.read<KnowledgebaseFilterCubit>().filter(value);
  }
}
