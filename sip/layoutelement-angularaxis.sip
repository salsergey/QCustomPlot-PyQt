/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Sergey Salnikov
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPPolarAxisAngular : public QCPLayoutElement
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  enum SelectablePart { spNone        = 0      ///< None of the selectable parts
                        ,spAxis       = 0x001  ///< The axis backbone and tick marks
                        ,spTickLabels = 0x002  ///< Tick labels (numbers) of this axis (as a whole, not individually)
                        ,spAxisLabel  = 0x004  ///< The axis label
                      };
  typedef QFlags<QCPPolarAxisAngular::SelectablePart> SelectableParts;

  enum LabelMode { lmUpright   ///<
                   ,lmRotated ///<
                 };

  explicit QCPPolarAxisAngular(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPPolarAxisAngular();

  // getters:
  QPixmap background() const;
  QBrush backgroundBrush() const;
  bool backgroundScaled() const;
  Qt::AspectRatioMode backgroundScaledMode() const;
  bool rangeDrag() const;
  bool rangeZoom() const;
  double rangeZoomFactor() const;

  const QCPRange range() const;
  bool rangeReversed() const;
  double angle() const;
  QCPAxisTicker* ticker() const;
  %MethodCode
    sipRes = sipCpp->ticker().data();
  %End
  bool ticks() const;
  bool tickLabels() const;
  int tickLabelPadding() const;
  QFont tickLabelFont() const;
  QColor tickLabelColor() const;
  double tickLabelRotation() const;
  LabelMode tickLabelMode() const;
  QString numberFormat() const;
  int numberPrecision() const;
  QVector<double> tickVector() const;
  QVector<QString> tickVectorLabels() const;
  int tickLengthIn() const;
  int tickLengthOut() const;
  bool subTicks() const;
  int subTickLengthIn() const;
  int subTickLengthOut() const;
  QPen basePen() const;
  QPen tickPen() const;
  QPen subTickPen() const;
  QFont labelFont() const;
  QColor labelColor() const;
  QString label() const;
  int labelPadding() const;
  SelectableParts selectedParts() const;
  SelectableParts selectableParts() const;
  QFont selectedTickLabelFont() const;
  QFont selectedLabelFont() const;
  QColor selectedTickLabelColor() const;
  QColor selectedLabelColor() const;
  QPen selectedBasePen() const;
  QPen selectedTickPen() const;
  QPen selectedSubTickPen() const;
  QCPPolarGrid *grid() const;

  // setters:
  void setBackground(const QPixmap &pm);
  void setBackground(const QPixmap &pm, bool scaled, Qt::AspectRatioMode mode=Qt::KeepAspectRatioByExpanding);
  void setBackground(const QBrush &brush);
  void setBackgroundScaled(bool scaled);
  void setBackgroundScaledMode(Qt::AspectRatioMode mode);
  void setRangeDrag(bool enabled);
  void setRangeZoom(bool enabled);
  void setRangeZoomFactor(double factor);

  Q_SLOT void setRange(const QCPRange &range);
  void setRange(double lower, double upper);
  void setRange(double position, double size, Qt::AlignmentFlag alignment);
  void setRangeLower(double lower);
  void setRangeUpper(double upper);
  void setRangeReversed(bool reversed);
  void setAngle(double degrees);
  void setTicker(QCPAxisTicker *ticker /Transfer/);
  %Docstring(format = "deindented", signature = "prepended")
    Set a new ticker on the axis. Ownership of the ticker is transferred to the axis
    and cannot be taken back.
  %End
  %MethodCode
    sipCpp->setTicker(QSharedPointer<QCPAxisTicker>(a0));
  %End
  void setTicks(bool show);
  void setTickLabels(bool show);
  void setTickLabelPadding(int padding);
  void setTickLabelFont(const QFont &font);
  void setTickLabelColor(const QColor &color);
  void setTickLabelRotation(double degrees);
  void setTickLabelMode(LabelMode mode);
  void setNumberFormat(const QString &formatCode);
  void setNumberPrecision(int precision);
  void setTickLength(int inside, int outside=0);
  void setTickLengthIn(int inside);
  void setTickLengthOut(int outside);
  void setSubTicks(bool show);
  void setSubTickLength(int inside, int outside=0);
  void setSubTickLengthIn(int inside);
  void setSubTickLengthOut(int outside);
  void setBasePen(const QPen &pen);
  void setTickPen(const QPen &pen);
  void setSubTickPen(const QPen &pen);
  void setLabelFont(const QFont &font);
  void setLabelColor(const QColor &color);
  void setLabel(const QString &str);
  void setLabelPadding(int padding);
//   void setLabelPosition(Qt::AlignmentFlag position);
  void setSelectedTickLabelFont(const QFont &font);
  void setSelectedLabelFont(const QFont &font);
  void setSelectedTickLabelColor(const QColor &color);
  void setSelectedLabelColor(const QColor &color);
  void setSelectedBasePen(const QPen &pen);
  void setSelectedTickPen(const QPen &pen);
  void setSelectedSubTickPen(const QPen &pen);
  Q_SLOT void setSelectableParts(const QCPPolarAxisAngular::SelectableParts &selectableParts);
  Q_SLOT void setSelectedParts(const QCPPolarAxisAngular::SelectableParts &selectedParts);

  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  virtual void update(UpdatePhase phase);
  virtual QList<QCPLayoutElement*> elements(bool recursive) const;

  // non-property methods:
  bool removeGraph(QCPPolarGraph *graph);
  int radialAxisCount() const;
  QCPPolarAxisRadial *radialAxis(int index=0) const;
  QList<QCPPolarAxisRadial*> radialAxes() const;
  QCPPolarAxisRadial *addRadialAxis(QCPPolarAxisRadial *axis=0);
  bool removeRadialAxis(QCPPolarAxisRadial *axis);
  QCPLayoutInset *insetLayout() const;
  QRegion exactClipRegion() const;

  void moveRange(double diff);
  void scaleRange(double factor);
  void scaleRange(double factor, double center);
  void rescale(bool onlyVisiblePlottables=false);
  double coordToAngleRad(double coord) const;
  double angleRadToCoord(double angleRad) const;
  void pixelToCoord(QPointF pixelPos, double &angleCoord, double &radiusCoord) const;
  QPointF coordToPixel(double angleCoord, double radiusCoord) const;
  SelectablePart getPartAt(const QPointF &pos) const;

  // read-only interface imitating a QRect:
  int left() const;
  int right() const;
  int top() const;
  int bottom() const;
  int width() const;
  int height() const;
  QSize size() const;
  QPoint topLeft() const;
  QPoint topRight() const;
  QPoint bottomLeft() const;
  QPoint bottomRight() const;
  QPointF center() const;
  double radius() const;

signals:
  void rangeChanged(const QCPRange &newRange);
  void rangeChanged(const QCPRange &newRange, const QCPRange &oldRange);
  void selectionChanged(const QCPPolarAxisAngular::SelectableParts &parts);
  void selectableChanged(const QCPPolarAxisAngular::SelectableParts &parts);

protected:
  // reimplemented virtual methods:
  virtual void applyDefaultAntialiasingHint(QCPPainter *painter) const;
  virtual void draw(QCPPainter *painter);
  virtual QCP::Interaction selectionCategory() const;
  // events:
  virtual void mousePressEvent(QMouseEvent *event, const QVariant &details);
  virtual void mouseMoveEvent(QMouseEvent *event, const QPointF &startPos);
  virtual void mouseReleaseEvent(QMouseEvent *event, const QPointF &startPos);
  virtual void wheelEvent(QWheelEvent *event);

  // non-virtual methods:
  bool registerPolarGraph(QCPPolarGraph *graph);
  void drawBackground(QCPPainter *painter, const QPointF &center, double radius);
  void setupTickVectors();
  QPen getBasePen() const;
  QPen getTickPen() const;
  QPen getSubTickPen() const;
  QFont getTickLabelFont() const;
  QFont getLabelFont() const;
  QColor getTickLabelColor() const;
  QColor getLabelColor() const;
};

QFlags<QCPPolarAxisAngular::SelectablePart> operator|(QCPPolarAxisAngular::SelectablePart f1, QFlags<QCPPolarAxisAngular::SelectablePart> f2);
QFlags<QCPPolarAxisAngular::SelectablePart> operator&(QCPPolarAxisAngular::SelectablePart f1, QFlags<QCPPolarAxisAngular::SelectablePart> f2);
