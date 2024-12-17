import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../home/data/model/debtor_installment_model.dart';
import '../../../../home/presentation/view_model/cubit/debtor_installment_cubit.dart';
import '../../../../home/presentation/view_model/cubit/debtor_installment_state.dart';

class DebtorGraphViewBody extends StatefulWidget {
  const DebtorGraphViewBody({super.key});

  @override
  State<DebtorGraphViewBody> createState() => _DebtorGraphViewBodyState();
}

class _DebtorGraphViewBodyState extends State<DebtorGraphViewBody> {
  late String selectedFilter;
  List<BarChartGroupData> getBarData(
      List<DebtorInstallmentModel> installments) {
    List<BarChartGroupData> barData = [];
    for (int i = 0; i < installments.length; i++) {
      double totalPaid = installments[i].totalPaid;
      double remainingAmount = installments[i].totalAmount - totalPaid;
      double adjustedTotalPaid = totalPaid == 0 ? 0.1 : totalPaid;
      double adjustRemaining = remainingAmount == 0 ? 0.1 : remainingAmount;
      barData.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: adjustedTotalPaid,
              color: Colors.blue,
              width: 15,
              borderRadius: BorderRadius.circular(3),
            ),
            BarChartRodData(
              toY: adjustRemaining,
              color: Colors.orange,
              width: 15,
              borderRadius: BorderRadius.circular(3),
            ),
          ],
        ),
      );
    }
    return barData;
  }

  List<String> getInstallmentNames(List<DebtorInstallmentModel> installments) {
    return installments.map((installment) => installment.title).toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedFilter = S.of(context).Uncompleted_Install;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DebtorInstallmentCubit, DebtorInstallmentState>(
      builder: (context, state) {
        if (state is DebtorInstallmentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DebtorInstallmentLoaded) {
          final installments = selectedFilter ==
                  S.of(context).Uncompleted_Install
              ? BlocProvider.of<DebtorInstallmentCubit>(context).allInstallments!
              : BlocProvider.of<DebtorInstallmentCubit>(context).completedInstallment;
          return CustomScaffold(
            appBar: CustomAppBar(title: S.of(context).graph_title),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: selectedFilter,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedFilter = newValue!;
                          });
                        },
                        items: <String>[
                          S.of(context).Uncompleted_Install,
                          S.of(context).completed_Install,
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: AppStyles.textStyle18black,
                            ),
                          );
                        }).toList(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ChartExplainWidget(
                            title: S.of(context).amount_paid,
                            color: Colors.blue,
                          ),
                          ChartExplainWidget(
                            title: S.of(context).remaining_amount,
                            color: Colors.orange,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      gridData: const FlGridData(show: true),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              int index = value.toInt();
                              if (index >= 0 && index < installments.length) {
                                return Text(
                                  getInstallmentNames(installments)[index],
                                  style: AppStyles.textStyle18black,
                                );
                              } else {
                                return const Text('');
                              }
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: getBarData(installments),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No Data Available'));
        }
      },
    );
  }
}

class ChartExplainWidget extends StatelessWidget {
  final String title;
  final Color color;
  const ChartExplainWidget(
      {super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(color: color),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: AppStyles.textStyle18black,
        ),
      ],
    );
  }
}
