import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: TreeViewPage(),
      );
}

class TreeViewPage extends StatefulWidget {
  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  bool _showChildNodes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TreeGraphView(
          showChildNodes: _showChildNodes,
          onTapGeneralManager: () {
            setState(() {
              _showChildNodes = !_showChildNodes;
            });
          },
        ),
      ),
    );
  }
}

class TreeGraphView extends StatefulWidget {
  final bool showChildNodes;
  final VoidCallback onTapGeneralManager;

  const TreeGraphView({
    required this.showChildNodes,
    required this.onTapGeneralManager,
  });

  @override
  _TreeGraphViewState createState() => _TreeGraphViewState();
}

class _TreeGraphViewState extends State<TreeGraphView> {
  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  bool isPositionNodeExpanded = false;

  @override
  void initState() {
    final generalManager = Node.Id('General Manager');
    final position = Node.Id('Position');
    final branch = Node.Id('Branch');
    final additionalGM = Node.Id('Additional General Manager');

    final dgm = Node.Id('DGM');
    final cpro = Node.Id('CPRO');
    final secretary = Node.Id('Secretary');

    final sdgm = Node.Id('SDGM');
    final pce = Node.Id('PCE');
    final pcme = Node.Id('PCME');
    final pcee = Node.Id('PCEE');
    final pfa = Node.Id('PFA');
    final pcste = Node.Id('PCSTE');
    final pcpo = Node.Id('PCPO');
    final pcmd = Node.Id('PCMD');
    final pcsc = Node.Id('PCSC');
    final pcmm = Node.Id('PCMM');
    final pccm = Node.Id('PCCM');
    final pcso = Node.Id('PCSO');
    final pcom = Node.Id('PCOM');

    final drmBB = Node.Id('DRM BB');
    final drmBSL = Node.Id('DRM BSL');
    final drmNGP = Node.Id('DRM NGP');
    final drmPune = Node.Id('DRM Pune');
    final drmSur = Node.Id('DRM Sur');

    graph.addEdge(generalManager, position);
    graph.addEdge(generalManager, branch);
    graph.addEdge(generalManager, additionalGM);

    graph.addEdge(position, dgm);
    graph.addEdge(position, cpro);
    graph.addEdge(position, secretary);

    graph.addEdge(branch, sdgm);
    graph.addEdge(branch, pce);
    graph.addEdge(branch, pcme);
    graph.addEdge(branch, pcee);
    graph.addEdge(branch, pfa);
    graph.addEdge(branch, pcste);
    graph.addEdge(branch, pcpo);
    graph.addEdge(branch, pcmd);
    graph.addEdge(branch, pcsc);
    graph.addEdge(branch, pcmm);
    graph.addEdge(branch, pccm);
    graph.addEdge(branch, pcso);
    graph.addEdge(branch, pcom);

    graph.addEdge(additionalGM, drmBB);
    graph.addEdge(additionalGM, drmBSL);
    graph.addEdge(additionalGM, drmNGP);
    graph.addEdge(additionalGM, drmPune);
    graph.addEdge(additionalGM, drmSur);

    builder
      ..siblingSeparation = 100
      ..levelSeparation = 150
      ..subtreeSeparation = 150
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      boundaryMargin: EdgeInsets.all(50),
      minScale: 0.01,
      maxScale: 5.6,
      child: GraphView(
        graph: graph,
        algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
        paint: Paint()
          ..color = widget.showChildNodes ? Colors.green : Colors.transparent
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke,
        builder: (Node node) {
          if (node.key?.value == 'General Manager') {
            return GestureDetector(
              onTap: widget.onTapGeneralManager,
              child: rectangleWidget(node.key?.value?.toString() ?? ''),
            );
          } else if (widget.showChildNodes &&
              (node.key?.value == 'Position' ||
                  node.key?.value == 'Branch' ||
                  node.key?.value == 'Additional General Manager')) {
            return GestureDetector(
              onTap: () {
                if (node.key?.value == 'Position') {
                  setState(() {
                    isPositionNodeExpanded = !isPositionNodeExpanded;
                  });
                }
              },
              child: rectangleWidget(node.key?.value?.toString() ?? ''),
            );
          } else if ((isPositionNodeExpanded &&
              (node.key?.value == 'DGM' ||
                  node.key?.value == 'CPRO' ||
                  node.key?.value == 'Secretary'))) {
            return rectangleWidget(node.key?.value?.toString() ?? '');
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget rectangleWidget(String label) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(color: Colors.blue, spreadRadius: 1)],
      ),
      child: Text(label),
    );
  }
}
