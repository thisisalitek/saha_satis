part of '../current_view.dart';

class _CurrentCardList extends StatelessWidget {
  const _CurrentCardList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentViewModel, CurrentState>(
      builder: (context, state) {
        if (state.isLoading) {
          return LoadingListWidget();
        }
        if (state.currentAccount.isEmpty) {
          return CustomEmptyWidget();
        }
        return AnimationLimiter(
          child: ListView.builder(
            itemCount: state.currentAccount.length,
            itemBuilder: (BuildContext context, int index) {
              final CurrentAccountModel current = state.currentAccount[index];
              return _animationWidget(index, context, current);
            },
          ),
        );
      },
    );
  }

  Widget _animationWidget(int index, BuildContext context, CurrentAccountModel current) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 250.0,
        child: FadeInAnimation(
          child: InkWell(
            onTap: () {
              context.router.push(CurrentDetailRoute(current: current));
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: ProjectBorderRadius.medium()),
              child: ListTile(
                isThreeLine: false,
                dense: false,
                title: Text(current.title1 ?? '', style: context.general.textTheme.bodyMedium),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowTextWidget(title: 'Kodu', description: current.code ?? ''),
                    RowTextWidget(title: '', description: current.title2 ?? ''),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
