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
  bool isBranchNodeExpanded = false;
  bool isAddtionalGmNodeExpanded = false;

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
      ..siblingSeparation = 65
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
              child: rectangleWidget(
                node.key?.value?.toString() ?? '',
                boxColor: Colors.red, // Set the box color to red
              ),
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
                } else if (node.key?.value == 'Branch') {
                  setState(() {
                    isBranchNodeExpanded = !isBranchNodeExpanded;
                  });
                } else if (node.key?.value == 'Additional General Manager') {
                  setState(() {
                    isAddtionalGmNodeExpanded = !isAddtionalGmNodeExpanded;
                  });
                }
              },
              child: rectangleWidget(node.key?.value?.toString() ?? ''),
            );
          } else if ((isPositionNodeExpanded &&
                  (node.key?.value == 'DGM' ||
                      node.key?.value == 'CPRO' ||
                      node.key?.value == 'Secretary')) ||
              (isBranchNodeExpanded &&
                  (node.key?.value == 'SDGM' ||
                      node.key?.value == 'PCE' ||
                      node.key?.value == 'PCME' ||
                      node.key?.value == 'PFA' ||
                      node.key?.value == 'PCPO' ||
                      node.key?.value == 'PCMD' ||
                      node.key?.value == 'PCEE' ||
                      node.key?.value == 'PCSTE' ||
                      node.key?.value == 'PCMM' ||
                      node.key?.value == 'PCSC' ||
                      node.key?.value == 'CAO/C' ||
                      node.key?.value == 'PCOM' ||
                      node.key?.value == 'PCCM' ||
                      node.key?.value == 'PCSO')) ||
              (isAddtionalGmNodeExpanded &&
                  (node.key?.value == 'DRM BB' ||
                      node.key?.value == 'DRM BSL' ||
                      node.key?.value == 'DRM Pune' ||
                      node.key?.value == 'DRM NGP' ||
                      node.key?.value == 'DRM Sur'))) {
            return rectangleWidget(
              node.key?.value?.toString() ?? '',
              boxColor: node.key?.value == 'DRM BB' ||
                      node.key?.value == 'DRM BSL' ||
                      node.key?.value == 'DRM Pune' ||
                      node.key?.value == 'DRM NGP' ||
                      node.key?.value == 'DRM Sur'
                  ? Colors.red
                  : null, // Set the box color to red for DRM nodes, else null
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget rectangleWidget(String label, {Color? boxColor}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: boxColor != null
              ? [boxColor, boxColor]
              : [Colors.lightBlueAccent, Colors.blue],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: boxColor != null ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}
